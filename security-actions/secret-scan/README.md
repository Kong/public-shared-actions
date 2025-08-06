# Secret Scanning - GitHub Action

This GitHub Action uses [TruffleHog OSS](https://github.com/trufflesecurity/trufflehog) to detect secrets and sensitive information in your repository's Git history or current changes.

The action performs the following:
- Scans the full Git history or specific ref range (`base` → `head`) for **verified** and **unknown** secrets.
- Configurable fail behavior based on detection results.
- Can be integrated into pull request, push, or manual (`workflow_dispatch`) workflows.

## Inputs

```yaml
base:
  description: 'Start scanning from this base ref (e.g., main). If empty, scans full history.'
  required: false
  default: ''
head:
  description: 'Scan commits until this ref (e.g., HEAD or branch name).'
  required: false
  default: HEAD
fail_on_findings:
  description: 'Fail job if TruffleHog detects findings/secrets'
  required: false
  default: false
  type: choice
  options:
    - 'true'
    - 'false'
```

## Outputs
Displays TruffleHog scan output in the GitHub Actions console.

The job will fail if `fail_on_findings` is set to `true` and secrets are detected.

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
    name: Secret Scanning
    runs-on: ubuntu-latest
    if: (github.actor != 'dependabot[bot]')

    steps:
      - uses: actions/checkout@<tag-commit-sha>
        with:
          fetch-depth: 0

      - uses: Kong/public-shared-actions/security-actions/secret-scan@<tag-commit-sha> # Replace with actual tag Commit SHA
        name: TruffleHog Secret Scan
        with:
          fail_on_findings: 'true'

```
