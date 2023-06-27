# Build JS SDK

This action builds a JavaScript SDK and updates an existing PR with the generated files

## Example

```yaml
name: Generate SDK Packages

on:
  pull_request:
    types:
      - opened
      - synchronize

permissions:
  contents: write

jobs:
  generate:
    name: Generate SDK
    runs-on: ubuntu-latest
    steps:
      - name: Build JS SDK
        uses: Kong/public-shared-actions/code-build-actions/build-js-sdk
  
```


