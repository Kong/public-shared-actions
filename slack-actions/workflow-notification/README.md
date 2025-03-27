# Slack Workflow Notifications

Utilize your existing Slack webhook URLs to post messages to Slack channels.

## Usage

```yaml
jobs:
  tests:
    name: Fake tests
    runs-on: ubuntu-latest
    timeout-minutes: 20
    steps:
      - name: Run fake tests
        run: |
          echo "Running tests..."
          # Success or fail, etc.

  notify:
    name: Post Slack notification
    needs: [tests] # Needs job above
    if: ${{ always() && (needs.tests.result == 'failure' || needs.tests.result == 'success') }}
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - name: Post Slack workflow notification
        uses: Kong/public-shared-actions/slack-actions/workflow-notification@v2
        with:
          slack-webhook-url: ${{ needs.tests.result == 'failure' && secrets.SLACK_WEBHOOK_URL_ALERT || secrets.SLACK_WEBHOOK_URL_NOTIFY }}
          status: ${{ needs.tests.result }}
          # Optionally customize the success and failure messages
          success-message: ":large_green_circle: This is my custom *success* message :mario_luigi_dance:"
          failure-message: ":red_circle: This is my custom *FAILURE* message :sad-panda:"
```

### Additional Statuses and messages

`inputs.status` accepts any one of: `success`, `failure`, `cancelled`, or `skipped` which correspond to the related `{status}-message` inputs.

### Custom Payload

You can set the `payload` input with content via [Slack Block Kit Builder](https://app.slack.com/block-kit-builder/) that will override the `header` `*-message` and other inputs to customize your notification.

```yaml
- name: Post 'success' notification with custom payload
  uses: ./slack-actions/workflow-notification
  with:
    slack-webhook-url: ${{ secrets.SLACK_WEBHOOK_URL_NOTIFY_SLACK_NOTIFICATION_TEST }}
    status: 'success'
    payload: |
      {
        "blocks": [
          {
            "type": "header",
            "text": {
              "type": "plain_text",
              "text": "[TEST] Kong/public-shared-actions",
              "emoji": true
            }
          },
          {
            "type": "context",
            "elements": [
              {
                "type": "mrkdwn",
                "text": ":test_tube:"
              },
              {
                "type": "mrkdwn",
                "text": "This is a test notification with a *custom payload*."
              }
            ]
          }
        ]
      }
```
