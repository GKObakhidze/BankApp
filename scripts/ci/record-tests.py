"""Record the exact simulator used by the UI test run, including failed runs."""
import os
from pathlib import Path
import signal
import subprocess
import time

results = Path('test-results')
results.mkdir(exist_ok=True)
udid = os.environ['SIMULATOR_UDID']
subprocess.run(['xcrun', 'simctl', 'boot', udid], check=True)
subprocess.run(['xcrun', 'simctl', 'bootstatus', udid, '-b'], check=True, timeout=180)

recorder = None
tests = None
status = 1
recording_ok = True


def interrupted(signum, frame):
    raise SystemExit(128 + signum)


signal.signal(signal.SIGTERM, interrupted)
signal.signal(signal.SIGINT, interrupted)
with (results / 'recording.log').open('w') as recording_log:
    try:
        recorder = subprocess.Popen(
            ['xcrun', 'simctl', 'io', udid, 'recordVideo', '--codec=h264',
             '--mask=ignored', str(results / 'simulator-recording.mov')],
            stdout=recording_log, stderr=subprocess.STDOUT,
        )
        deadline = time.monotonic() + 30
        while 'Recording started' not in (results / 'recording.log').read_text():
            if recorder.poll() is not None:
                raise RuntimeError('Simulator recorder exited. See recording.log.')
            if time.monotonic() > deadline:
                raise TimeoutError('Simulator recording did not start within 30 seconds.')
            time.sleep(0.2)

        command = [
            'xcodebuild', 'test-without-building', '-project', 'EasyBank.xcodeproj',
            '-scheme', 'EasyBank', '-configuration', 'Debug',
            '-destination', f'platform=iOS Simulator,id={udid}',
            '-destination-timeout', '180', '-parallel-testing-enabled', 'NO',
            '-only-testing:EasyBankUITests',
            '-resultBundlePath', str(results / 'EasyBank.xcresult'),
            '-derivedDataPath', 'build/DerivedData',
            '-disableAutomaticPackageResolution', 'CODE_SIGNING_ALLOWED=NO',
        ]
        with (results / 'xcodebuild.log').open('w') as test_log:
            tests = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
            for line in tests.stdout:
                print(line, end='', flush=True)
                test_log.write(line)
                test_log.flush()
            status = tests.wait()
    finally:
        if tests is not None and tests.poll() is None:
            tests.terminate()
            try:
                tests.wait(timeout=15)
            except subprocess.TimeoutExpired:
                tests.kill()
                tests.wait()
        if recorder is not None:
            if recorder.poll() is None:
                recorder.send_signal(signal.SIGINT)
                try:
                    recorder.wait(timeout=45)
                except subprocess.TimeoutExpired:
                    recorder.kill()
                    recorder.wait()
                    recording_ok = False
            else:
                recording_ok = False
        if not recording_ok:
            print('::error::Simulator recording stopped unexpectedly or could not be finalized.')

raise SystemExit(status if status else (0 if recording_ok else 1))
