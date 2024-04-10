# Semgrep SAST - Github Action

This action uses Semgrep CI command to scan all supported platforms on a specified scan path

The action runs the following:
- Self detects config rules from semgrep registry
- Applies any additional arguments / configuration rules passed to semgrep
- Provides a optional input to fail downstream builds based on semgrep findings

## Action Output

- Report Semgrep Finding Summary as Console output
- Report Findings 
  - Private repositories: workflow artifact file
  - Public repositories: Github Security tab 
- The failure mode of build is configurable based on shared action outcome

## Detailed example

> [!IMPORTANT]
Create a GH workflow file `sast.yml` under `.github/workflows` folder

```yaml
name: Semgrep

on:
  pull_request: {}
  push:
    branches: 
    - master
    - main
  workflow_dispatch: {}


jobs:
  semgrep:
    name: SAST
    runs-on: ubuntu-20.04
    permissions:
      # required for all workflows
      security-events: write
      # only required for workflows in private repositories
      actions: read
      contents: read

    if: (github.actor != 'dependabot[bot]')

    steps:
      - uses: actions/checkout@v3
      - uses: Kong/public-shared-actions/security-actions/semgrep@main
        with:
          additional_config: '--config p/rust'
            

```