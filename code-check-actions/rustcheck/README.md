# Rust Directory Scan - Github Action

This action uses syft and grype for SCA. It will only support scanning source code directories / files and will not support the container images


The action runs the following:
- Installs rust and tools like clippy and fmt
- Runs `rust fmt`
- Runs `rust check`
- Runs `rust clippy` for all standard lint groups in Warn Mode
- SBOM in spdx and cyclonedx.
- CVE sarif and json 

## User tracking

Currently, these repos are using this action:

[]

## Inputs

```yaml
args: 
    description: 'Arguments to luacheck'
    required: 'false'
    default: '.' # Default: Run luacheck on workspace dir 
```

## Action status
The status outcome of the action will depend based on the follwing:

- Exit code is 0 if no warnings or errors occurred.
- Exit code is 1 if some warnings occurred but there were no syntax errors or invalid inline options.
- Exit code is 2 if there were some syntax errors or invalid inline options.
- Exit code is 3 if some files couldn’t be checked, typically due to an incorrect file name.
- Exit code is 4 if there was a critical error (invalid CLI arguments, config, or cache file).

## Example usage

```yaml
uses: Kong/public-shared-actions/code-check-actions/rustcheck@main

```

## Detailed example

```yaml
name: Test Rust Lint and SCA Checks

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-rust-checks:
    outputs:
      grype-report: ${{ steps.rust_checks.outputs.grype-sarif-report }}
      sbom-spdx-report: ${{ steps.rust_checks.outputs.sbom-spdx-report }}
      sbom-cyclonedx-report: ${{ steps.rust_checks.outputs.sbom-cyclonedx-report }}
    runs-on: ubuntu-latest
    name: Rust scan and vulnerability SCA checks
    steps:
      - uses: actions/checkout@v3
      - id: rust_checks
        uses: Kong/public-shared-actions/code-check-actions/rustcheck@main
        with:
          asset_prefix: ${{ env.DOCKER_BASE_IMAGE_NAME }}
          dir: ${{ github.workspace }}
```