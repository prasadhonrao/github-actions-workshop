## Solution: `repository_dispatch` Trigger Workflow

```yaml
name: Intro - Repository Dispatch Trigger Workflow

on:
  workflow_dispatch:
  repository_dispatch:
    types: [trigger-from-api]

jobs:
  echo:
    runs-on: ubuntu-latest
    steps:
      - name: Echo a message
        run: echo "This workflow was triggered via HTTP using repository_dispatch!"
```
