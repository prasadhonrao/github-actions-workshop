## Solution: Python Upper App CI/CD

```yaml
name: Python Upper App CI/CD
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/python-upper-app-ci-cd.yml'
      - 'src/python/upper_project/**'

jobs:
  test-and-package:
    strategy:
      matrix:
        os: [windows-latest, ubuntu-latest, macos-latest]
        python-version: ['3.10', '3.11']
    runs-on: ${{ matrix.os }}
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python-version }}

      - name: Print Python Version
        run: python --version

      - name: Upgrade pip
        run: python -m pip install --upgrade pip

      - name: Run Unit Tests
        run: python -m unittest discover tests
        working-directory: src/python/upper_project

      - name: Install pyinstaller
        run: pip install pyinstaller

      - name: Package Executable
        run: |
          pyinstaller --onefile upper/upper.py
        working-directory: src/python/upper_project

      - name: List Packaged Files
        run: ls -R ./src/python/upper_project/dist

      - name: Upload Artifact
        uses: actions/upload-artifact@v3
        with:
          name: upper-executable-${{ matrix.os }}-${{ matrix.python-version }}
          path: src/python/upper_project/dist/*

      - name: Test Executable
        run: |
          if [[ "$RUNNER_OS" == "Windows" ]]; then
            ./dist/upper.exe Hello World
          else
            ./dist/upper Hello World
          fi
        working-directory: src/python/upper_project
        shell: bash
```
