# iOS UI tests from Windows

This trial runs the existing `EasyBankUITests` target on a GitHub-hosted Mac with Xcode 16.4 and an iOS 18.5 iPhone Simulator. Your computer only needs an editor, Git and a browser. There is no interactive simulator window in GitHub Actions.

The starter tests exercise app launch and basic login navigation. A green run does not mean the three assignment scenarios have been implemented, or that Firebase registration and authentication have been verified.

## Run the trial

1. Open this branch on GitHub: `codex/ios-actions-trial`.
2. Open **Actions**, then the **iOS UI Tests** run created by the branch push.
3. Open **EasyBank on iPhone Simulator** to see the build and test steps.
4. On the run summary, read the test totals. Under **Artifacts**, download `ios-ui-test-results-<number>` and unzip it.
5. Read `report.md` and `xcodebuild.log` on Windows. Open images in `attachments/` to see captured simulator screens. The `.xcresult` bundle is included for Mac users.
6. To repeat the same commit, use **Re-run all jobs** on the completed run. To test changed code, push another commit to the trial branch.

**Run workflow** is available only after this manually dispatchable workflow also exists on the repository's default branch. During this isolated trial, use push or re-run; no change to `main` is needed.

## Student branches

Once the setup is adopted, students can enable Actions in their own fork, edit Swift files in `EasyBankUITests/`, and push a branch named `UITests/firstname-bankapp`. The workflow runs on those pushes and on pull requests into `main`. New Swift files in the existing UI test folder are included through the project's synchronized group.

Each hosted run uses a fresh environment. Do not depend on accounts created manually on a different simulator. Existing app authentication still depends on Firebase; this workflow does not replace that service.

The workflow uploads reports for seven days. Reports are produced even when a test fails, when Xcode has enough result data. Build failures may only have logs. A failed build or test remains a failed GitHub check.
