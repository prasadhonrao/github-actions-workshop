## Solution: K8s ARC Runner

```yaml
name: K8s ARC Runner

on:
  push:
    paths:
      - '.github/workflows/k8s-arc-runner.yml'
  workflow_dispatch:

jobs:
  run:
    runs-on: arc-runner-set
    steps:
      - run: echo "🎉 This job uses runner scale set runners!"
```
