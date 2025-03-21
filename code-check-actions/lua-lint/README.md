# Lua Check - Github Action

Luacheck is a static analyzer for Lua. The options for static analysis configuration can be used on the command line, put into a config file or directly into checked files as Lua comments.

This action analyzes all changed lua files using [lunarmodules/luacheck](https://github.com/lunarmodules/luacheck).

This action looks for any `cli` arguments and a deafult `.luacheckrc` config to derive the final configuaration as mentioned in [docs](https://luacheck.readthedocs.io/en/stable/cli.html#command-line-options)

## Inputs

```yaml
additional_args: 
    description: 'Arguments to luacheck'
    required: 'false'
    default: '.' # Default: Run luacheck on workspace dir 
```

## Outputs
- Depending on the event, refer [publishing](https://github.com/EnricoMi/publish-unit-test-result-action#publishing-test-results)

## Action Output
- Always exit with 0 even when there are warnings / errors and be non-blocking
- The failure mode of build is not configurable based on shared action outcome

## Example usage

> [!IMPORTANT]
Create/Update a GH workflow file `lint.yml` under `.github/workflows` folder

```yaml
name: Lua Code Quality

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
  lua:
    name: Lua Lint
    runs-on: ubuntu-20.04
    permissions:
      contents: read
      issues: read
      checks: write
      pull-requests: write
    if: (github.actor != 'dependabot[bot]')

    steps:
    - name: Checkout source code
      uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683
    
    # Optional step to run on only changed files
    - name: Get changed files
      id: changed-files
      uses: kong/changed-files@4edd678ac3f81e2dc578756871e4d00c19191daf
      with: 
        files: |
          **.lua
    
    - name: Lua Check
      if: steps.changed-files.outputs.any_changed == 'true'
      uses: Kong/public-shared-actions/code-check-actions/luacheck@main
      with:
        additional_args: '--no-default-config --config .luacheckrc'
        files: ${{ steps.changed-files.outputs.all_changed_files }}
```

