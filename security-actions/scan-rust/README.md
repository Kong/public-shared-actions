# Rust SCA

This action uses grype for source code analysis. It will only support scanning source code directories / files and will not support the container images


The action runs the following:
- SCA and CVE analysis using Grype
- Uploads SCA results to Github Security for public repiositories

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

## Outputs:
- SARIF upload to github code scanning for public repositories
- Console log workflow output / Github check for reporting

## Detailed example

```yaml
name: Rust SCA

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
    name: Rust SCA
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

    - name: Source Code analysis
      uses: Kong/public-shared-actions/security-actions/scan-rust@main
      with:
        asset_prefix: 'atc-router'
```