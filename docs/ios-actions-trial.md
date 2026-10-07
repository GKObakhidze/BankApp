# iOS UI tests from Windows

This trial runs the existing `EasyBankUITests` target on a GitHub-hosted Mac with Xcode 16.4 and an iOS 18.5 iPhone Simulator. Your computer only needs an editor, Git and a browser. There is no interactive simulator window in GitHub Actions.

The starter tests exercise app launch and basic login navigation. A green run does not mean the three assignment scenarios have been implemented, or that the assignment scenarios have been verified.

## Run the trial

1. Open this branch on GitHub: `codex/ios-actions-trial`.
2. Open **Actions**, then the **iOS UI Tests** run created by the branch push.
3. Open **EasyBank on iPhone Simulator** to see the build and test steps.
4. On the run summary, read the test totals. Under **Artifacts**, download `ios-ui-test-results-<number>` and unzip it.
5. Open `ui-tests.mp4` in Windows Media Player or VLC. Read `report.md`, `build.log` and `xcodebuild.log` on Windows. Open images in `attachments/` to see captured simulator screens. The `.xcresult` bundle is included for Mac users.
6. To repeat the same commit, use **Re-run all jobs** on the completed run. To test changed code, push another commit to the trial branch.

**Run workflow** is available only after this manually dispatchable workflow also exists on the repository's default branch. During this isolated trial, use push or re-run; no change to `main` is needed.

## Student setup on Windows

Install Git and VS Code. Xcode and an iOS Simulator are not installed on Windows; compilation and execution take place on the GitHub-hosted Mac. Local editor diagnostics are not a substitute for the Xcode build result.

During the pilot, start from **`codex/ios-actions-trial`**, because `main` does not yet include this setup:

1. Fork `GKObakhidze/BankApp` into your own GitHub account. Open the fork's **Actions** tab and enable workflows if prompted.
2. Clone your fork, replacing `YOUR_USERNAME` below with your GitHub username:

   ```bash
   git clone https://github.com/YOUR_USERNAME/BankApp.git
   cd BankApp
   git remote add upstream https://github.com/GKObakhidze/BankApp.git
   git fetch upstream codex/ios-actions-trial
   git switch -c UITests/firstname-bankapp upstream/codex/ios-actions-trial
   code .
   ```

   Fetching upstream also works when the fork copied only `main`. Replace `firstname` with your own name.

3. Open [the screen and element reference](ios-element-reference.md). Use it to write your own Swift tests in `EasyBankUITests/`.
4. Commit your changes and push `UITests/firstname-bankapp` to **origin**, your fork. The branch name must begin with `UITests/` to trigger the workflow.
5. Open **Actions → iOS UI Tests** in your fork. Select the run for your latest commit and inspect its build/test results and artifacts.
6. Fix failures in VS Code, commit and push again. Re-running a job runs the same committed code, not unsaved local edits.

The workflow runs on `UITests/**` pushes and on pull requests into `main`. New Swift files in the existing UI test folder are included through the project's synchronized group. Run from your fork for independent feedback; a pull request workflow in the teaching repository may require mentor approval.

After the mentor adopts this setup on `main`, new student branches can start from updated `main`. Until then, use the pilot base above. See GitHub's [workflow event documentation](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows) for fork workflow enablement.

Each hosted run uses a fresh environment. The app starts in local training mode: create an account within your test instead of depending on an account from another simulator. Accounts persist only inside the same app installation; logout clears the session, not the registered account. Firebase is not used in this mode.

The workflow uploads reports for seven days. Reports are produced even when a test fails, when Xcode has enough result data. Build failures may only have logs. A failed build or test remains a failed GitHub check.

## Test videos

The shared `EasyBank` scheme asks Xcode to record each UI test and keep recordings for passing and failing tests. The workflow exports those recordings from the `.xcresult` bundle and converts them to Windows-compatible MP4. It does not use a separate background simulator recorder.

Open `ui-tests.mp4` for the combined recording, or use `videos.md` to choose a clip in `videos/`. Clips correspond to individual test executions, including separate appearance configurations. Simulator setup before a test is omitted. Test launches and relaunches can still appear.

The final files use H.264 Main profile, 8-bit YUV 4:2:0, 30 fps and a 720 × 1280 frame. This avoids relying on HEVC extensions on Windows. Every converted clip and the combined video are decoded as a validation step. Codec details are saved in `video-info.json`. Recordings are silent; Xcode's interactive timeline overlays are not part of the exported video.

The workflow builds with ad-hoc simulator signing; no Apple account or signing certificate is needed. A missing recording causes the video export step to fail instead of silently publishing an empty video. Build failures may only produce logs.

This is a recording available after the run, not a live remote simulator or an element inspector. Use the prepared [screens, identifiers and UI trees](ios-element-reference.md) to identify elements. This Windows assignment assesses test implementation using a supplied UI reference; live element inspection is not required.
