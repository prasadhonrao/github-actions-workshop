## Solution: Environment Variables and Secrets

```yaml
name: Env Var and Secrets

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/env-var-secrets.yml'

jobs:
  print:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        environment: [dev, prod]

    environment: ${{ matrix.environment }}

    steps:
      - name: Display Environment Variable
        run: |
          echo "Building for environment: ${{ matrix.environment }}"
          echo "ENVIRONMENT_NAME: $ENVIRONMENT"
          echo "ENVIRONMENT_NAME length: ${#ENVIRONMENT}"
          echo "ENVIRONMENT_NAME (partial): ${ENVIRONMENT:0:5}..."
        env:
          ENVIRONMENT: ${{ vars.ENVIRONMENT }}

      - name: Display Environment Secret
        run: |
          echo "SECRET length: ${#SECRET}"
        env:
          SECRET: ${{ secrets.SECRET }}

      - name: Display Repository Variable
        run: |
          echo "REPOSITORY_VARIABLE: ${{ vars.REPOSITORY_VARIABLE }}"
```
