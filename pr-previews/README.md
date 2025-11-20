# PR preview actions

Set of action for deal with PR previews of NPM packages and  consumption of those PR previews.

## Action implemented

- [PR preview actions](#pr-preview-actions)
  - [Action implemented](#action-implemented)
    - [Audit](#validate)
      - [Example](#example)
    - [Up-to-date](#up-to-date)
      - [Example](#example-1)
    - [Cleanup](#cleanup)
      - [Example](#example-2)


### Audit

Audit pull requests and detects issues that blocks merging.
workflow fails when one or more of the following conditions are met:

- Open Renovate security PRs detected
- PNPM audit detects critical or high vulnerabilities
- No test coverage detected
- Too many open renovate PRs detected

#### Example

  # code should be checked in with fetch-depth=0 before up-to-date action could be used
  - name: Check out the code
    uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683
    with:
      fetch-depth: 0

  - name: Check if PR Up to Date
    id: 'pr-audit'
    uses: Kong/public-shared-actions/pr-previews/audit
    with:
      github_token: ${{ secrets.GITHUB_TOKEN }}

### Up-to-date

Is/was the PR associated with the workflow commit up to date? Works for open PRs and Squash Merges.
When PR is merged to main, we run this action to figure out do we need to run any tests on main.
If action returns `true` this means that the code in PR was `up-to-date` wih main and tests executed in PR workflow  do not need to be re-run on merge. Saves us some time and in many cases makes release workflow much faster.

#### Example

```yaml

  # code should be checked in with fetch-depth=0 before up-to-date action could be used
  - name: Check out the code
    uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683
    with:
      fetch-depth: 0

  - name: Check if PR Up to Date
    id: 'up-to-date'
    uses: Kong/public-shared-actions/pr-previews/up-to-date@main
    with:
      github_token: ${{ secrets.GITHUB_TOKEN }}
```

### Cleanup

Deprecates and Unpublishes PR preview packages for closed PRs. To be executed from CRON as often as you need.
#### Example

```yaml

  # code should be checked out
  - name: Check out the code
    uses: actions/checkout@11bd71901bbe5b1630ceea73d27597364c9af683

  - name: Cleanup
    uses: Kong/public-shared-actions/pr-previews/cleanup@main
    with:
      # package to cleanup PR preview versions for
      package: "@kong-ui/core"
      # list of open PRs (when PR preview is for one of the open PRs - it's not getting deprecated or unpublished)
      openPRs: "[23,123,434]"
    env:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN_PRIVATE_PUBLISH }}

```
