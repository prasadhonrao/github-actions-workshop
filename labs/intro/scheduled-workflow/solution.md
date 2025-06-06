## Solution: Scheduled Workflow

```yaml
name: Intro - Scheduled Workflow

on:
  workflow_dispatch:
  schedule:
    - cron: '*/5 * * * *' # Every 5 minutes. You can use https://crontab.guru/ to generate cron expressions
  push:
    paths:
      - '.github/workflows/intro-scheduled-workflow.yml'
jobs:
  execute:
    runs-on: ubuntu-latest
    steps:
      - name: Display current date and time
        run: echo "The current date and time is $(date)"
```
