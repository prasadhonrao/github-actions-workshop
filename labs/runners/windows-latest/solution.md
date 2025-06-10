## Solution: Runner - Windows Latest

```yaml
name: Runner - Windows Latest

on: workflow_dispatch

jobs:
  run:
    runs-on: windows-latest
    steps:
      - run: echo "This is a message from windows latest runner"
      - name: Display OS Information
        run: |
          systeminfo
```
