# CIS Compliance Scan Action

A composite GitHub Action for running CIS (Center for Internet Security) compliance scans using Legitify with automated SARIF report generation and GitHub Code Scanning integration.

## Features

- **CIS Compliance Scanning**: Uses Legitify to check GitHub organization and repository configurations against CIS benchmarks
- **Human-readable Results**: Displays formatted results table directly in workflow logs
- **SARIF Integration**: Can automatically upload security findings to GitHub Code Scanning
- **Artifact Management**: Uploads scan reports as workflow artifacts for download
- **Flexible Configuration**: Supports custom repositories, scorecard integration, and upload options

## Usage

### Basic Usage

```yaml
- name: Run CIS Compliance Scan
  uses: Kong/public-shared-actions/security-actions/cis-scans@COMMIT-SHA
  with:
    github_token: ${{ secrets.CLASSIC_PAT }}
    repositories: ${{ github.repository }}
```

### Scheduled Weekly Scan (Recommended)

```yaml
name: CIS GH Legitify Compliance Scan

on:
  schedule:
    - cron: '0 6 * * 1'  # Weekly Monday 6 AM
  workflow_dispatch: {}

permissions:
  contents: read
  security-events: write

jobs:
  cis-compliance-scan:
    name: GH CIS Compliance Scan
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run Legitify CIS Scan
        uses: Kong/public-shared-actions/security-actions/cis-scans@COMMIT-SHA
        with:
          github_token: ${{ secrets.SECURITY_BOT_LEGITIFY_TOKEN }}
          repositories: "${{github.repository_owner}}/httpsnippet"
          codeql_upload: 'true'
```

## Inputs

| Input | Description | Required | Default |
|-------|-------------|----------|---------|
| `github_token` | GitHub Classic PAT with appropriate permissions for Legitify scan | ✅ | - |
| `repositories` | Repository to be scanned | ✅ | - |
| `codeql_upload` | Upload results to GitHub Code Scanning | ❌ | `false` |
| `scorecard` | Enable OpenSSF Scorecard integration | ❌ | `'no'` |
| `artifact_name` | Name for the artifact containing scan results | ❌ | `'legitify-cis-scan-results'` |

## Outputs & Reports

The action generates multiple output formats:

### 2. GitHub Code Scanning Integration
- SARIF report automatically uploaded to Security tab
- Findings appear alongside other code scanning results
- **Note**: Only works for public repositories and when `codeql_upload` is set to `true`

### 3. Workflow Artifacts
All scan outputs are uploaded as artifacts:
- `legitify-output.sarif` - SARIF format for security tools

## Required Permissions

### Workflow Permissions
```yaml
permissions:
  contents: read
  security-events: write  # For SARIF upload
```

### Token Permissions
The GitHub token needs these scopes:
- `admin:org` - Organization management
- `read:enterprise` - Enterprise settings
- `admin:org_hook` - Organization webhooks
- `read:org` - Organization metadata
- `repo` - Repository access
- `read:repo_hook` - Repository webhooks

## When to Use This Action

**✅ Recommended for:**
- Weekly scheduled scans in individual repositories
- Security compliance audits
- One-time security assessments


## Common Issues

**Private Repository SARIF Upload:**
Code Scanning uploads are automatically disabled for private repositories as they're not supported by GitHub's free tier.

## Notes

- Built on top of [Legitify](https://github.com/Legit-Labs/legitify) by Legit Security
- Results appear in workflow logs immediately after scan completion
- SARIF reports integrate seamlessly with GitHub's Security tab
- Action uses `continue-on-error: true` to ensure artifact upload even if scan finds issues
- Report is available as GitHub Artifact