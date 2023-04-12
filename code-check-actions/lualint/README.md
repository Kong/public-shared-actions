# Lua Lint - Github Action

This action lints all changed lua files using [kong/lualint](https://github.com/kong/lualint).

## User tracking

Currently, these repos are using this action:

* [Kong/atc-router](https://github.com/Kong/atc-router/) (State: PR)
* [Kong/lua-resty-lmdb](https://github.com/Kong/lua-resty-lmdb/) (State: PR)

## Inputs

### `kong_gh_app_id`

**Required** The app ID of the GitHub app used to generate a token.

### `kong_gh_app_private_key`

**Required** The private key of the GitHub app used to generate a token.

### `rules`

A JSON string of the rules to use for linting. Default: `'{"max_column_width": {}, "one_line_before_else": {}, "eof_blank_line": {}, "table_ctor_comma": {}, "func_separation": {}}'`.

## Example usage

```yaml
uses: Kong/public-shared-actions/code-check-actions/lualint@feat-lualint
with:
  kong_gh_app_id: ${{ secrets.KONG_GH_APP_ID }}
  kong_gh_app_private_key: ${{ secrets.KONG_GH_APP_PRIVATE_KEY }}
  rules: '{"max_column_width": {"width": 80}, "one_line_before_else": {}, "eof_blank_line": {}, "table_ctor_comma": {"style":"trailing"}, "func_separation": {}}'
  extra_args: ''
```

## Detailed example

Here is an example that is already used in Kong/atc-router:

```yaml
name: Lua lint

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  lualint:
    runs-on: ubuntu-latest
    name: Lua code style check
    steps:
      - uses: Kong/public-shared-actions/code-check-actions/lualint@feat-lualint
        with:
          kong_gh_app_id: ${{ vars.KONG_GH_APP_ID }}
          kong_gh_app_private_key: ${{ secrets.KONG_GH_APP_PRIVATE_KEY }}
```
