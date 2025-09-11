# CIS Compliance Scan Action

A composite GitHub Action for running CIS (Center for Internet Security) compliance scans with automated report generation and artifact upload.

## Features

- CIS benchmark compliance scanning
- Formatted results table in job summary
- SARIF report generation and artifact upload
- Configurable failure behavior
- Debug logging support
- Security events integration

## Usage

### Basic Usage

```yaml
- name: Run CIS Compliance Scan
  uses: Kong/public-shared-actions/security-actions/scan-cis@COMMIT-SHA
  with:
    github_token: ${{ secrets.PAT }}
    repositories: ${{ github.repository }}
```


## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `github_token` | GitHub token with appropriate permissions | ✅ | - |
| `repositories` | Comma-separated list of repositories to scan | ❌ | `''` |
| `fail_on_findings` | Fail job if compliance issues are detected | ❌ | `'false'` |
| `upload_code_scanning` | Upload results to GitHub Code Scanning | ❌ | `'true'` |
| `scorecard` | Enable OpenSSF Scorecard integration | ❌ | `'no'` |
| `artifact_name` | Name for the artifact containing scan results | ❌ | `'legitify-cis-scan-results'` |
| `publish_results_table` | Publish results in formatted table | ❌ | `'true'` |

## Outputs

- **SARIF Report**: Generated as `legitify-output.sarif`
- **Job Summary**: Formatted table with scan results 
- **Artifacts**: Uploaded scan reports for download
- **Security Events**: Integration with GitHub Security tab

## Example Workflow

```yaml
name: CIS Compliance Scan

on:
  pull_request:
  push:
    branches: [main]

permissions:
  contents: read
  security-events: write

jobs:
  cis-scan:
    name: CIS Compliance Scan
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@COMMIT-SHA

      - name: Run CIS Scan
        uses: Kong/public-shared-actions/security-actions/scan-cis@COMMIT-SHA
        with:
          github_token: ${{ secrets.PAT }}
          repositories: ${{ github.repository }}
          fail_on_findings: "false"
```

## Permissions Required

The action requires the following permissions:

```yaml
permissions:
  contents: read
  discussions: read
  issues: read
  pull-requests: read
  security-events: write
```

## Artifacts

The action generates and uploads:
- `legitify-output.sarif` - SARIF format security report
- Results are available in the workflow's "Artifacts" section

## Notes

- The action uses Legitify for CIS compliance scanning
- SARIF reports are only uploaded when the scan completes successfully
- WIP- Results are displayed in both job summary tables and GitHub Security tab
