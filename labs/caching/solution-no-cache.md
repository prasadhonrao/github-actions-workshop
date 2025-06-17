## Solution: Caching - Express Server No Cache

```yaml
name: Caching - Express Server without cache

on:
  workflow_dispatch:

jobs:
  no-cache-build:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Show installed packages
        run: npm list
```
