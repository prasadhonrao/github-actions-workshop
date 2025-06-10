## Solution: Runner - Self Hosted

```yaml
name: Runner - Self Hosted

on: workflow_dispatch

jobs:
  run:
    runs-on: self-hosted
    steps:
      - run: echo "This is a message from self hosted runner"
      - name: Display OS Information
        run: |
          systeminfo
```
