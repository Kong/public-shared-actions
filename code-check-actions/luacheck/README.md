# Lua Check - Github Action

Luacheck is a static analyzer for Lua. The options for static analysis configuration can be used on the command line, put into a config file or directly into checked files as Lua comments.

This action analyzes all changed lua files using [lunarmodules/luacheck](https://github.com/lunarmodules/luacheck).

This action looks for any `cli` arguments and a deafult `.luacheckrc` config to derive the final configuaration as mentioned in [docs](https://luacheck.readthedocs.io/en/stable/cli.html#command-line-options)

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
uses: Kong/public-shared-actions/code-check-actions/luacheck@main

```

## Detailed example

```yaml
name: Luacheck

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  luacheck:
    runs-on: ubuntu-latest
    name: Lua code analysis check
    steps:
      - uses: actions/checkout@v3
      - name: Get changed files
        id: changed-files
        uses: tj-actions/changed-files@04124efe7560d15e11ea2ba96c0df2989f68f1f4
        with:
          base_sha: ${{ github.event.workflow_run.head_sha }}
      - uses: Kong/public-shared-actions/code-check-actions/luacheck@main
        with:
            args: "${{ steps.changed-files.outputs.all_changed_files }}"
```