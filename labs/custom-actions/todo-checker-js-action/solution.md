## Solution: Create and Run a Custom JavaScript Action to Check TODO Comments in Code

```yaml
name: Custom JavaScript Action - TODO Checker

on:
  workflow_dispatch:

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
