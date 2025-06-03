## Lab: Python Upper App CI/CD

This lab will guide you through creating a CI/CD pipeline for the Python Upper App using GitHub Actions. The pipeline tests the app and packages it into platform-specific executables for Windows, macOS, and Linux.

---

## Lab Objectives

- Set up a GitHub Actions workflow for the Python Upper App.
- Test the app across multiple Python versions and operating systems.
- Package the app into standalone executables.
- Upload the executables as artifacts.

---

## Prerequisites

Before starting this lab, ensure that you have read the [Python Upper App Overview](./python-upper-app-overview.md) to have your Python Upper App ready for this lab.

---

## Instructions

### Step 1: Initialize the Workflow File

1. Navigate to your repository on GitHub.
2. Go to **Actions** > **New workflow**.
3. Select **Set up a workflow yourself**.
4. Name the file `.github/workflows/python-upper-app-ci-cd.yml`.
5. Add the following base structure to the file:

```yaml
name: Python Upper App CI/CD
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/python-upper-app-ci-cd.yml'
      - 'src/python/upper_project/**'
```

### Step 2: Define the Job Strategy

1. Add a job named `test-and-package`.
2. Configure the matrix strategy to run the workflow on:
   - Operating Systems: `windows-latest`, `ubuntu-latest`, `macos-latest`.
   - Python Versions: `3.10`, `3.11`.

```yaml
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
```

---

### Step 3: Set Up Python

1. Use the `actions/setup-python@v4` action to set up Python.
2. Specify the `python-version` from the matrix.

```yaml
- name: Setup Python
  uses: actions/setup-python@v4
  with:
    python-version: ${{ matrix.python-version }}
```

3. Add a step to print the Python version for debugging:

```yaml
- name: Print Python Version
  run: python --version
```

---

### Step 4: Run Unit Tests

1. Upgrade `pip` to the latest version:

```yaml
- name: Upgrade pip
  run: python -m pip install --upgrade pip
```

2. Add a step to run the unit tests:

```yaml
- name: Run Unit Tests
  run: python -m unittest discover tests
  working-directory: src/python/upper_project
```

---

### Step 5: Install PyInstaller

1. Add a step to install `pyinstaller`, which is required to package the application:

```yaml
- name: Install pyinstaller
  run: pip install pyinstaller
```

---

### Step 6: Package the Application

1. Use `pyinstaller` to create a standalone executable:

```yaml
- name: Package Executable
  run: |
    pyinstaller --onefile upper/upper.py
  working-directory: src/python/upper_project
```

2. Add a step to list the packaged files for verification:

```yaml
- name: List Packaged Files
  run: ls -R ./src/python/upper_project/dist
```

---

### Step 7: Upload Executables as Artifacts

1. Use the `actions/upload-artifact@v3` action to save the executables.

```yaml
- name: Upload Artifact
  uses: actions/upload-artifact@v3
  with:
    name: upper-executable-${{ matrix.os }}-${{ matrix.python-version }}
    path: src/python/upper_project/dist/*
```

---

### Step 8: Test the Packaged Executable

1. Add a step to test the executable:
2. Use a conditional statement to handle different OS-specific executable formats.

```yaml
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

---

### Final Workflow File

After completing the steps above, your workflow file should look like this:

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

---

### Validation

1. Push your changes to GitHub.
2. Trigger the workflow manually or through a new commit.
3. Verify:
   - All tests pass.
   - Artifacts for each OS and Python version are uploaded.
   - Executables run successfully.

---

## Summary

In this lab, you learned how to create a CI/CD workflow for the Python Upper App using GitHub Actions. The workflow tests the app, packages it into standalone executables, and uploads the artifacts for distribution. You can further enhance the workflow by adding deployment steps or integrating with external services.
