# PR preview actions

Set of action for deal with PR previews and PR preview consumptions.

## Action implemented

- [PR preview actions](#pr-preview-actions)
  - [Action implemented](#action-implemented)
    - [Validate](#validate)
      - [Example](#example)
    - [Up-to-date](#up-to-date)
      - [Example](#example-1)
    - [Cleanup](#cleanup)
      - [Example](#example-2)
### Validate

Validate that no package.json in the current repository references PR preview of dependent package.
If PR preview of dependant package is found - action will throw an error

#### Example

```yaml
  - name: Validate No PR preview references
    uses: Kong/shared-actions/pr-previews/validate@main
```

To be used `on pullrequest` to prevent merging PRs that references PR previews of depended packages


### Up-to-date

Is/was the PR associated with the workflow commit up to date? Works for open PRs and Squash Merges.
When PR is merged to main, we run this action to figure out do we need to run any tests on main.
If action returns `true` this means that the code in PR was `up-to-date` wih main and tests executed in PR workflow  do not need to be re-run on merge. Saves us some time and in many cases makes release workflow much faster.

#### Example

```yaml

  # code should be checked in with fetch-depth=0 before up-to-date action could be used
  - name: Check out the code
    uses: actions/checkout@v3
    with:
      fetch-depth: 0

  - name: Check if PR Up to Date
    id: 'up-to-date'
    uses: Kong/shared-actions/pr-previews/up-to-date@main
    with:
      github_token: ${{ secrets.GITHUB_TOKEN }}
```

### Cleanup

Deprecates and Unpublishes PR preview packages for closed PRs. To be executed from CRON as often as you need.
#### Example

```yaml

  # code should be checked out
  - name: Check out the code
    uses: actions/checkout@v3

  - name: Cleanup
    uses: Kong/shared-actions/pr-previews/cleanup@main
    with:
      # package to cleanup PR preview versions for
      package: "@kong-ui/core"
      # list of open PRs (when PR preview is for one of the open PRs - it's not getting deprecated or unpublished)
      openPRs: "[23,123,434]"
    env:
      NPM_TOKEN: ${{ secrets.NPM_TOKEN_PRIVATE_PUBLISH }}

```
