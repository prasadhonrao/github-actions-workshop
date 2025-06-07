## Solution: Create and Run a Custom Docker Action to Print a Message

```yaml
name: Custom Docker Action - Print Message

on:
  push:
    paths:
      - '.github/actions/print-message-container-action/**'
      - '.github/workflows/custom-container-action-print-message.yml'
  workflow_dispatch:

jobs:
  hello-docker:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Run Hello Docker Action
        uses: ./.github/actions/print-message-container-action
        with:
          message: 'This is a custom message from the workflow!'
```
