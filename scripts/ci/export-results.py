"""Export Xcode results as text and images that students can read on Windows."""
import json
import os
from pathlib import Path
import subprocess

results = Path('test-results')
results.mkdir(exist_ok=True)
bundle = results / 'EasyBank.xcresult'
lines = ['## Test results', '']
report_ok = False
if bundle.exists():
    command = subprocess.run(
        ['xcrun', 'xcresulttool', 'get', 'test-results', 'summary', '--path', str(bundle)],
        capture_output=True, text=True,
    )
    if command.returncode == 0:
        data = json.loads(command.stdout)
        (results / 'summary.json').write_text(json.dumps(data, indent=2), encoding='utf-8')
        total = data.get('totalTestCount', 0)
        lines += [
            f"Result: **{data.get('result', 'Unknown')}**", '',
            '| Total | Passed | Failed | Skipped |', '| --- | --- | --- | --- |',
            f"| {total} | {data.get('passedTests', 0)} | {data.get('failedTests', 0)} | {data.get('skippedTests', 0)} |", '',
        ]
        for failure in data.get('testFailures', []):
            lines += ['```text', str(failure.get('testName', 'Test failure')),
                      str(failure.get('failureText', failure)), '```', '']
        report_ok = total > 0
        if not report_ok:
            lines += ['No tests executed. Inspect `xcodebuild.log`.', '']
    else:
        (results / 'report-error.log').write_text(command.stderr, encoding='utf-8')
        lines += ['Xcode did not produce a readable test summary. Inspect `xcodebuild.log` and `report-error.log`.', '']

    exported = subprocess.run(
        ['xcrun', 'xcresulttool', 'export', 'attachments', '--path', str(bundle),
         '--output-path', str(results / 'attachments')], capture_output=True, text=True,
    )
    if exported.returncode:
        (results / 'attachments-error.log').write_text(exported.stderr, encoding='utf-8')
        lines += ['Screenshots could not be exported. See `attachments-error.log`.', '']
else:
    lines += ['The build did not create a test result bundle. Inspect the failed workflow step and `xcodebuild.log` if present.', '']

lines += [
    'Download the **ios-ui-test-results** artifact below and unzip it.',
    'Open `report.md` in a text editor. Screenshots, when captured, are in `attachments/`.',
    '`build.log` and `xcodebuild.log` contain build and test diagnostics. The `.xcresult` bundle requires Xcode for its graphical viewer.', '',
    'The starter has one test: BankingFlowTests/testAppLaunch(). Replace it with your three scenario tests; a passing starter run does not complete the assignment.', '',
]
video = results / 'ui-tests.mp4'
if video.exists():
    lines += ['### Test video', '',
              'Open **ui-tests.mp4** after unzipping the artifact. The file is MP4 with H.264 video, suitable for Windows Media Player and VLC.',
              'The recording is silent. It shows simulator screens during the tests, without a touch/cursor overlay.', '']
report = '\n'.join(lines)
(results / 'report.md').write_text(report, encoding='utf-8')
if os.environ.get('GITHUB_STEP_SUMMARY'):
    with open(os.environ['GITHUB_STEP_SUMMARY'], 'a', encoding='utf-8') as output:
        output.write(report)
print(report)
if not report_ok:
    raise SystemExit(1)
