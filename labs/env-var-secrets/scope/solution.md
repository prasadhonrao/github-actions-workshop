## Solution: Environment Variable Scope

```yaml
name: Env Var Scope

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/env-var-scope.yml'

env:
  WORKFLOW_ENV_VAR: 'Workflow Environment Variable'

jobs:
  print:
    runs-on: ubuntu-latest

    env:
      JOB_ENV_VAR: 'Job Environment Variable'

    steps:
      - name: Display Environment Variables
        env:
          STEP_ENV_VAR: 'Step Environment Variable'
        run: |
          echo "WORKFLOW_ENV_VAR: $WORKFLOW_ENV_VAR"
          echo "JOB_ENV_VAR: $JOB_ENV_VAR"
          echo "STEP_ENV_VAR: $STEP_ENV_VAR"
```
