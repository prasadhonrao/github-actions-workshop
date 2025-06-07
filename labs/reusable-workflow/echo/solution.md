## Solution: Reusable Workflow

## Reusable Echo Workflow

```yaml
name: Reusable Workflow Echo
on:
  workflow_call:
    inputs:
      my-input:
        required: true
        type: string
jobs:
  echo:
    runs-on: ubuntu-latest
    steps:
      - name: Echo input
        run: echo ${{ inputs.my-input }}
```

## Reusable Workflow Echo Caller

```yaml
name: Reusable Workflow Echo Caller

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/reusable-workflow-echo-caller.yml'
jobs:
  say-hello:
    uses: ./.github/workflows/reusable-workflow-echo.yml
    with:
      my-input: 'Hello, world!'
  say-goodbye:
    uses: ./.github/workflows/reusable-workflow-echo.yml
    with:
      my-input: 'Goodbye!'
```
