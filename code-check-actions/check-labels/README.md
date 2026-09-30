# Check PR Labels - GitHub Action

## What does this action do?

You have a `do not merge` label (or any label you choose) in your repository. When a PR carries that label, the PR should not be merged. This action adds a check to the PR that **fails while the label is present** and **passes once it is removed**.

> [!IMPORTANT]
> The check is only enforced if you mark the job as **required** in your branch protection ruleset(s).

Think of it as an automated hand on the merge button: as long as someone keeps the label on the PR, this check stays red, and - if you mark it as a required check - GitHub refuses to merge.

How it stays fast and simple: the action does not check out code or call the GitHub API. It reads the label list from the event that triggered the workflow, so it runs in seconds and works on fork PRs with no token.

## Inputs

| Input  | Description                  | Required | Default        |
| ------ | ---------------------------- | -------- | -------------- |
| `label` | PR label that blocks the merge | No     | `do not merge` |

## Example usage

>IMPORTANT: Create a workflow file check-labels.yml under .github/workflows/ in your repository or use it directly within your workflow where needed

```yaml
name: Check PR Labels

on:
  pull_request:
    # 'labeled'/'unlabeled' MUST be listed. Without them, adding the label
    # after CI has finished does not re-run this check (see caveats below).
    types:
      - opened
      - reopened
      - synchronize
      - labeled
      - unlabeled

# Cancel stale runs for the same PR, e.g. when labels are toggled rapidly
concurrency:
  group: ${{ github.workflow }}-${{ github.event.number }}
  cancel-in-progress: true

jobs:
  label-do-not-merge:
    name: Check PR for do not merge label
    runs-on: ubuntu-latest # Substitute with your repo's preferred runner
    timeout-minutes: 5
    permissions:
      contents: read
    steps:
      - name: Fail on blocking label
        uses: Kong/public-shared-actions/code-check-actions/check-labels@<tag-commit-sha> # Replace with actual tag Commit SHA
        with:
          label: 'do not merge' # Optional, this is the default
```

## Caveats

These are the everyday things to know, in rough order of "how likely this is to bite you":

1. **The check is only enforced if you mark it as required.** The action adds a check, but merging is only blocked when this job is listed under **Settings → Branches → Required status checks**. The required check name must match the job name exactly (`label-do-not-merge` in the example above).

2. **Trigger types matter.** GitHub's default `pull_request` types do *not* include `labeled`/`unlabeled`. If you write a bare `on: pull_request`, adding the label after CI completes will not re-run the check, and the last green run stays green until the next push. Keep the `types:` block from the example.

3. **The label match is exact and case-sensitive.** `Do Not Merge` does not match `do not merge`, and a typo in the `label` input does not produce an error - the check just always passes. Make sure the input matches the label name in your repository character for character.

4. **The check only means something on PR events.** It reads labels from the event that triggered the run. If the workflow also runs on other events (`push`, `workflow_dispatch`, merge queue `merge_group` runs, ...), it has no PR to look at and silently passes. Do not add other triggers to this workflow; if you use a merge queue, this check is not the right tool for the queue stage.

5. **Empty input disables the check.** `label: ''` passes on every PR. Use the default or a real label name.
