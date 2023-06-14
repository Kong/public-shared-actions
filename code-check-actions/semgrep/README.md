# Semgrep SAST - Github Action

This action uses Semgrep CI command to scan all supported platforms on a specified scan path


The action runs the following:
- Self detects config rules from semgrep registry

## User tracking

Currently, these repos are using this action:

[]

## Inputs

```yaml
additional_args: 
    description: 'Arguments to Semgrep'
    required: 'false'
    default: '.' # Default: Run Semgrep on workspace dir 
```
## Example usage

```yaml
uses: public-shared-actions/code-check-actions/semgrep@main

```

## Detailed example

```yaml
name: Semgrep SAST checks

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  test-semgrep-sast:
    permissions:
      # required for all workflows
      security-events: write
      # only required for workflows in private repositories
      actions: read
      contents: read
    runs-on: ubuntu-latest
    name: Semgrep SAST checks
    steps:
      - uses: actions/checkout@v3
      - id: sast_check
        uses: Kong/public-shared-actions/code-check-actions/semgrep@main
```