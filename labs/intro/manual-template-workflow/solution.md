## Solution: Manual Workflow

```yaml
name: Intro - Manual Workflow

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/intro-manual-workflow.yml'
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Hows GitHub Actions?
        run: echo "Awesome!!"
```
