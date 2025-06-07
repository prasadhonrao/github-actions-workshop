## Solution: Using Git CLI in GitHub Actions

```yaml
name: Misc - Git CLI Integration
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/misc-misc-misc-git-cli-integration.yml'
jobs:
  run-on-ubuntu-latest:
    runs-on: ubuntu-latest
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v4
      - run: env
      - run: gh --version
      - run: gh auth status
      - run: gh repo list
      - run: gh workflow list
  run-on-windows-latest:
    runs-on: windows-latest
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v4
      - run: env
      - run: gh --version
      - run: gh auth status
      - run: gh repo list
      - run: gh workflow list
  run-on-macos-latest:
    runs-on: macos-latest
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v4
      - run: env
      - run: gh --version
      - run: gh auth status
      - run: gh repo list
      - run: gh workflow list
  run-on-self-hosted:
    runs-on: self-hosted
    env:
      GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - uses: actions/checkout@v4
      # - run: env # Code commented as env command is not available in Windows
      - run: gh --version
      - run: gh auth status
      - run: gh repo list
      - run: gh workflow list
```
