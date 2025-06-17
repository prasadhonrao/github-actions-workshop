## Solution: Event - Pull Request

```yaml
name: Event - Pull Request

on:
  pull_request:
    branches:
      - main

jobs:
  create-environment:
    runs-on: ubuntu-latest
    steps:
      # Step 1: Checkout the repository
      - name: Checkout Code
        uses: actions/checkout@v3

      # Step 2: Set up dynamic environment name
      - name: Set Environment Name
        id: set-environment
        run: |
          # Generate a dynamic environment name based on PR number
          PR_NUMBER=${{ github.event.pull_request.number }}
          echo "environment-name=pr-${PR_NUMBER}" >> $GITHUB_ENV

      # Step 3: Deploy to the dynamically created environment
      - name: Deploy Application
        env:
          DEPLOY_ENV: ${{ env.environment-name }}
        run: |
          echo "Deploying application to environment: $DEPLOY_ENV"
          # Add your deployment commands here
```
