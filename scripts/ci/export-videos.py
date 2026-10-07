"""Convert Xcode's per-test recordings into portable MP4s and one combined video."""
import json
import os
from pathlib import Path
import re
import subprocess

results = Path('test-results')
attachments = results / 'attachments'
manifest = attachments / 'manifest.json'
if not manifest.exists():
    raise SystemExit('No Xcode attachments were exported. Inspect the build/test logs.')

clips = []
for test in json.loads(manifest.read_text()):
    for attachment in test.get('attachments', []):
        source = attachments / attachment['exportedFileName']
        if source.suffix.lower() in ('.mp4', '.mov'):
            clips.append((attachment.get('timestamp', 0), test.get('testName', test.get('testIdentifier', 'UI test')), source))
if not clips:
    raise SystemExit('No Xcode test videos were captured. Check the shared scheme screen capture settings.')

videos = results / 'videos'
videos.mkdir(exist_ok=True)
index = ['## Test videos', '', 'Open `ui-tests.mp4` for all recorded test runs, or choose an individual clip below.', '',
         'These videos come directly from Xcode UI test attachments. They omit simulator setup before each test.', '',
         '| Test | Video |', '| --- | --- |']
converted = []
metadata = []
for number, (_, test_name, source) in enumerate(sorted(clips, key=lambda item: item[0]), start=1):
    slug = re.sub(r'[^A-Za-z0-9_-]+', '-', test_name).strip('-')[:90] or 'test'
    output = videos / f'{number:02d}-{slug}.mp4'
    subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'warning', '-y', '-i', str(source),
                    '-vf', 'scale=720:1280:force_original_aspect_ratio=decrease:force_divisible_by=2,pad=720:1280:(ow-iw)/2:(oh-ih)/2,setsar=1',
                    '-c:v', 'libx264', '-profile:v', 'main', '-level:v', '3.1', '-pix_fmt', 'yuv420p',
                    '-r', '30', '-movflags', '+faststart', '-an', str(output)], check=True)
    subprocess.run(['ffmpeg', '-hide_banner', '-v', 'error', '-i', str(output), '-f', 'null', '-'], check=True)
    probe = subprocess.check_output(['ffprobe', '-v', 'error', '-show_entries',
                                    'stream=codec_name,profile,pix_fmt,width,height,r_frame_rate:format=duration,size',
                                    '-of', 'json', str(output)], text=True)
    metadata.append({'test': test_name, 'file': str(output.relative_to(results)), **json.loads(probe)})
    converted.append(output)
    safe_name = test_name.replace('|', '\\|').replace('\n', ' ')
    index.append(f'| {safe_name} | [{output.name}](videos/{output.name}) |')

concat = videos / 'concat.txt'
concat.write_text(''.join(f"file '{path.name}'\n" for path in converted))
subprocess.run(['ffmpeg', '-hide_banner', '-loglevel', 'warning', '-y', '-f', 'concat', '-safe', '1',
                '-i', str(concat), '-c', 'copy', '-movflags', '+faststart', str(results / 'ui-tests.mp4')], check=True)
subprocess.run(['ffmpeg', '-hide_banner', '-v', 'error', '-i', str(results / 'ui-tests.mp4'), '-f', 'null', '-'], check=True)
concat.unlink()
(results / 'video-info.json').write_text(json.dumps(metadata, indent=2))
report = '\n'.join(index) + '\n\nFormat: MP4 / H.264 Main / YUV 4:2:0 / 30 fps; silent.\n'
(results / 'videos.md').write_text(report)
with (results / 'report.md').open('a') as handle:
    handle.write('\n' + report)
if os.environ.get('GITHUB_STEP_SUMMARY'):
    with open(os.environ['GITHUB_STEP_SUMMARY'], 'a') as handle:
        handle.write('\n## Test videos\n\nDownload the artifact and open **ui-tests.mp4**. Individual clips are listed in **videos.md**.\n')
print(report)
