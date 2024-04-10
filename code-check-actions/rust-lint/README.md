# Rust clippy - Github Action

This action uses Rust Clippy for code quality checks


The action runs the following:
- Installs rust
- Run `clippy` to identify linting and code quality checks

## Inputs

```yaml
manifest_dir: 
  description: 'Speicify a directory to be scanned'
  required: false
  default: '.'
```

## Outputs:

- All Clippy Findings are reported as `Warnings` on the github check `Rust Clippy Report`

- On Push: Commit check summary
- On PRs (Forked repositories not supported): Github check Summary and PR annotations

## Action Output

- Report findings as warnings and be non-blocking
- The failure mode of build is not configurable based on shared action outcome

## Detailed example

> [!IMPORTANT]
Create/Update a GH workflow file `lint.yml` under `.github/workflows` folder

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
    name: Rust Clippy
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
      uses: Kong/public-shared-actions/code-check-actions/rust-lint@main
      with:
        token: ${{ secrets.GITHUB_TOKEN }}
```