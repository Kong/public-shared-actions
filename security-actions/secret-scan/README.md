# Secret Scanning - GitHub Action

This GitHub Action uses [TruffleHog OSS](https://github.com/trufflesecurity/trufflehog) to detect secrets and sensitive information in your repository's Git history or current changes.

## Features
- Scans only the relevant commit range based on GitHub event context (e.g., PR diffs).
- Detects **verified** and **unknown** secrets with TruffleHog’s verification engine.
- Configurable failure behavior to block CI on secret detection.
- Supports debug logging via environment variable.


## Inputs

```yaml
inputs:
  fail_on_findings:
    description: 'Fail job if TruffleHog detects findings/secrets'
    required: true
    default: false
```

## Environment Variables
You can set this optional environment variable in the workflow to control TruffleHog’s log verbosity:
`0` = Info (default)
`5` = Debug/Trace levels (higher = trace mode)

If `ACTIONS_STEP_DEBUG=true` in downstream workflow -> log level is set to `5`
Else -> log level is set to `0`

## Outputs
* Displays TruffleHog scan output in the GitHub Actions console.
* The job will fail if `fail_on_findings` is set to `true` and secrets are detected.
* The scanner will update the pull request diff view with specific callouts of any credentials that are present.

## Recommended Workflow Setup
>IMPORTANT: Create a workflow file secret-scan.yml under .github/workflows/ in your repository or use it directly within your workflow where needed

```yaml
name: Secret Scan

on:
  pull_request: {}
  push:
    branches:
      - main
      - master
  workflow_dispatch: {}

jobs:
  secret-scan:
    name: secret-scan
    runs-on: ubuntu-latest
    if: (github.actor != 'dependabot[bot]')
    steps:
      - uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683
        with: 
          fetch-depth: 0  # TruffleHog's default behavior relies on commit history (base -> head), so full fetch-depth is required

      - uses: Kong/public-shared-actions/security-actions/secret-scan@<tag-commit-sha> # Replace with actual tag Commit SHA
        name: Running Secret Scan using Trufflehog
        with:
          fail_on_findings: 'true'
        # env:
        #   ACTIONS_STEP_DEBUG: true
```

## Best Practices / Recommendation
To ensure secrets do not make it into your protected branches (e.g., `main`, `master`), it is strongly recommended to enable **Branch Protection Rules** in your repository settings:

1. Go to **Repository → Settings → Branches**
2. Click **"Add branch ruleset" or "Add classic branch protection rule"** (or edit an existing rule for `main`/`master`)
3. Enable:
   - ✅ **Require status checks to pass before merging**
   - ✅ **Select the GitHub Actions job for secret scanning** (e.g., `secret-scan`) as a required check

This will prevent PRs from being merged if TruffleHog detects a secret and the `secret-scan` job fails.
> Combined with `fail_on_findings: true`, this ensures secret leaks are caught and blocked at the PR level.

## [False Positives](https://docs.trufflesecurity.com/pre-commit-hooks#Ro3Lw)
* If you're getting false positives:
* Use the `--results=verified` flag to only show verified secrets
* Add `trufflehog:ignore` comments on lines with known false positives or risk-accepted findings. This only works if the scanned source [supports line numbers](https://github.com/trufflesecurity/trufflehog/blob/d6375ba92172fd830abb4247cca15e3176448c5d/pkg/engine/engine.go#L358-L365)

## Notes
* The scanner will also annotate the **PR diff** view with inline callouts for leaked secrets (when available).
* Use `TRUFFLEHOG_LOG_LEVEL: 5` during debugging to see full scan output.
* The `fetch-depth: 0` option is required to ensure TruffleHog can access commit ranges used for scanning.
