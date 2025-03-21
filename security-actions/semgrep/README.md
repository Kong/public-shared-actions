# Semgrep SAST - Github Action

This action uses Semgrep CI command to scan all supported platforms on a specified scan path

The action runs the following:
- Auto detects rules from semgrep registry using the default `--config auto` in **CI mode**
- [Additional arguments / configuration](https://semgrep.dev/docs/cli-reference) can be supplied using `additional_config` input
- Provides an optional input to fail downstream builds based on semgrep findings

## Inputs

```yaml
additional_config:
    description: 'Provide additional config to semgrep ci command'
    required: false
    default: ''
codeql_upload:
  description: 'Toggle to upload results to Github code scanning for public repositories'
  required: false
  default: true
  type: choice
  options:
  - 'true'
  - 'false'
fail_on_findings:
  description: 'Fail build / job on semgrep findings/errors'
  required: false
  default: false
  type: choice
  options:
  - 'true'
  - 'false'
```

## Outputs

- Report Semgrep Finding Summary as Console output
- Report Findings as follows:
  - Private repositories: workflow artifact file
  - Public repositories: Github Security tab 
- The failure mode of build is configurable based on shared action outcome

## Detailed example

> [!IMPORTANT]
Create a GH workflow file `sast.yml` under `.github/workflows` folder with the below:

```yaml
name: Semgrep

# Customize as suitable
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
    runs-on: ubuntu-latest
    permissions:
      # required for all workflows
      security-events: write
      # only required for workflows in private repositories
      actions: read
      contents: read

    if: (github.actor != 'dependabot[bot]')

    steps:
      - uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683
      - uses: Kong/public-shared-actions/security-actions/semgrep@<version> # Replace and pin public shared actions version
```
