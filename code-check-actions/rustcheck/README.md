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
name: Rust Code Quality

on:
  pull_request: {}
  workflow_dispatch: {}
  push:
    branches:
      - main

concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: ${{ github.event_name == 'pull_request' }}

jobs:
  rust:
    name: Rust Clippy & SCA
    runs-on: ubuntu-20.04
    
    permissions:
      # required for all workflows
      security-events: write
      checks: write
      pull-requests: write
      # only required for workflows in private repositories
      actions: read
      contents: read
  
    if: (github.actor != 'dependabot[bot]')
    
    steps:
    - name: Checkout source code
      uses: actions/checkout@v3

    - name: Rust Check
      uses: Kong/public-shared-actions/code-check-actions/rustcheck@main
      with:
        asset_prefix: 'atc-router'
        token: ${{ secrets.GITHUB_TOKEN }}
```