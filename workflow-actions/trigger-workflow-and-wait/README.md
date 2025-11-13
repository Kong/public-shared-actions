# Trigger Workflow and Wait

GitHub Action for trigger a workflow from another workflow and waits for it to complete.

## Arguments

| Argument Name            | Required | Default             | Description                                                                                      |
|--------------------------|----------|---------------------|--------------------------------------------------------------------------------------------------|
| `owner`                  | True     | N/A                 | The owner of the repository where the workflow is contained.                                     |
| `repo`                   | True     | N/A                 | The repository where the workflow is contained.                                                  |
| `github_token`           | True     | N/A                 | The Github access token with access to the repository. Its recommended you put it under secrets. |
| `workflow_file_name`     | True     | N/A                 | The reference point. For example, you could use main.yml.                                        |
| `github_user`            | False    | N/A                 | The name of the github user whose access token is being used to trigger the workflow.            |
| `ref`                    | False    | main                | The reference of the workflow run. The reference can be a branch, tag, or a commit SHA.          |
| `wait_interval`          | False    | 10                  | The number of seconds delay between checking for result of run.                                  |
| `client_payload`         | False    | `{}`                | Payload to pass to the workflow, must be a JSON string                                           |
| `propagate_failure`      | False    | `true`              | Fail current job if downstream job fails.                                                        |
| `trigger_workflow`       | False    | `true`              | Trigger the specified workflow.                                                                  |
| `wait_workflow`          | False    | `true`              | Wait for workflow to finish.                                                                     |
| `comment_downstream_url` | False    | ``                  | A comments API URL to comment the current downstream job URL to. Default: no comment             |
| `comment_github_token`   | False    | `${{github.token}}` | token used for pull_request comments                                                             |

## Example

### Simple

```yaml
- uses: Kong/public-shared-actions/workflow-actions/trigger-workflow-and-wait@1.0.0
  with:
    owner: Kong
    repo: myrepo
    github_token: mytoken
    workflow_file_name: tests.yml
```

### All Options

```yaml
- uses: Kong/public-shared-actions/workflow-actions/trigger-workflow-and-wait@1.0.0
  with:
    owner: Kong
    repo: myrepo
    github_token: mytoken
    github_user: github-user
    workflow_file_name: tests.yml
    ref: release-branch
    wait_interval: 10
    client_payload: '{}'
    propagate_failure: false
    trigger_workflow: true
    wait_workflow: true
```

### Comment the current running workflow URL for a PR

```yaml
- uses: Kong/public-shared-actions/workflow-actions/trigger-workflow-and-wait@1.0.0
  with:
    owner: Kong
    repo: myrepo
    github_token: ${{ secrets.GITHUB_PERSONAL_ACCESS_TOKEN }}
    workflow_file_name: tests.yml
    comment_downstream_url: ${{ github.event.pull_request.comments_url }}
```
