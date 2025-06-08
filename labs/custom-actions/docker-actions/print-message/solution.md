## Solution: Create and Run a Custom Docker Action to Print a Message

```yaml
name: Custom Action - Docker - Print Message

on:
  push:
    paths:
      - '.github/actions/print-message-container-action/**'
      - '.github/workflows/custom-action-docker-print-message.yml'
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
          message: '**** GitHub Actions is Awesome! ****'
```
