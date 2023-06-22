# Lua Check - Github Action

Luacheck is a static analyzer for Lua. The options for static analysis configuration can be used on the command line, put into a config file or directly into checked files as Lua comments.

This action analyzes all changed lua files using [lunarmodules/luacheck](https://github.com/lunarmodules/luacheck).

This action looks for any `cli` arguments and a deafult `.luacheckrc` config to derive the final configuaration as mentioned in [docs](https://luacheck.readthedocs.io/en/stable/cli.html#command-line-options)

## User tracking

Currently, these repos are using this action:

[]

## Inputs

```yaml
additional_args: 
    description: 'Arguments to luacheck'
    required: 'false'
    default: '.' # Default: Run luacheck on workspace dir 
```

## Action status
The status outcome of the action will depend based on the follwing:

<!-- - Exit code is 0 if no warnings or errors occurred.
- Exit code is 1 if some warnings occurred but there were no syntax errors or invalid inline options.
- Exit code is 2 if there were some syntax errors or invalid inline options.
- Exit code is 3 if some files couldn’t be checked, typically due to an incorrect file name.
- Exit code is 4 if there was a critical error (invalid CLI arguments, config, or cache file). -->

- Always exit with 0 even when there are warnings / errors and be non-blocking
## Example usage

```yaml
uses: public-shared-actions/code-check-actions/luacheck@main

```

## Detailed example

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
      uses: actions/checkout@v3
    
    # Optional step to run on only changed files
    - name: Get changed files
      id: changed-files
      uses: tj-actions/changed-files@v36
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