## Solution: Create and Run a Custom JavaScript Action to Check TODO Comments in Code

```yaml
name: Custom Action - JavaScript - TODO Checker

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/actions/todo-checker-javascript-action/**'
      - '.github/workflows/custom-action-javascript-todo-checker.yml'

jobs:
  check-todos:
    runs-on: ubuntu-latest

    steps:
      # Checkout the repository
      - name: Checkout code
        uses: actions/checkout@v4

      # Run the custom JavaScript action
      - name: Run TODO Checker
        uses: ./.github/actions/todo-checker-javascript-action
        with:
          path: './src' # Directory to scan
          strict: false # Do not fail the build if todos are found
```
