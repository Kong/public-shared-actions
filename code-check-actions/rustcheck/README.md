# Rust Directory Scan - Github Action

This action uses syft and grype for SCA. It will only support scanning source code directories / files and will not support the container images


The action runs the following:
- Installs rust and tools like clippy
- Runs `rust clippy` for linting in Warn Mode
- SCA and CVE analysis using Syft and Grype
- Uploads SCA results to Github Security for public repiositories
## User tracking

Currently, these repos are using this action:

[]

## Inputs

```yaml
asset_prefix:
    description: 'prefix for generated artifacts'
    required: false
    default: ''
dir: 
  description: 'Speicify a directory to be checked and scanned'
  required: false
  default: '.'
fail_build:
  description: 'fail the build if the vulnerability is above the severity cutoff'
  required: false
  default: false
  type: choice
  options:
  - 'true'
  - 'false'
```
## Example usage

```yaml
uses: public-shared-actions/code-check-actions/rustcheck@main

```

## Detailed example

```yaml
name: Rust Lint and SCA Checks

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-rust-sca-checks:
    permissions:
      # required for all workflows
      security-events: write
      # only required for workflows in private repositories
      actions: read
      contents: read
    outputs:
      grype-report: ${{ steps.rust_checks.outputs.grype-sarif-report }}
      sbom-spdx-report: ${{ steps.rust_checks.outputs.sbom-spdx-report }}
      sbom-cyclonedx-report: ${{ steps.rust_checks.outputs.sbom-cyclonedx-report }}
    runs-on: ubuntu-latest
    name: Rust Lint and SCA checks
    steps:
      - uses: actions/checkout@v3
      - id: rust_checks
        uses: Kong/public-shared-actions/code-check-actions/rustcheck@main
```