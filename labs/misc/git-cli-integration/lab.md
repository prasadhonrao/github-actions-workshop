## Lab: Using Git CLI in GitHub Actions

---

### Introduction

In this lab, you will learn how to integrate the GitHub CLI (`gh`) into GitHub Actions workflows. The GitHub CLI allows you to programmatically interact with GitHub, enabling operations like managing repositories, workflows, and more directly from your workflows.

> **Estimated Duration**: 10-15 minutes

---

### Directory Structure

Ensure the following directory structure exists in your repository:

```plaintext
.github/
└── workflows/
    └── misc-github-cli-integration.yml
```

---

### Workflow File

Create the workflow file `.github/workflows/misc-github-cli-integration.yml` with the following content:

```yaml
name: Misc - GitHub CLI Integration

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/misc-github-cli-integration.yml'

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

---

### Workflow Details

This workflow demonstrates the use of the GitHub CLI across four environments:

1. **`ubuntu-latest`**: A Linux-based runner.
2. **`windows-latest`**: A Windows-based runner.
3. **`macos-latest`**: A macOS-based runner.
4. **`self-hosted`**: A custom runner hosted in your environment.

#### Key Steps:

1. **Install and Authenticate GitHub CLI**:

   - The CLI is pre-installed in GitHub-hosted runners.
   - Authentication is done using the built-in `GITHUB_TOKEN` secret.

2. **CLI Commands**:
   - `gh --version`: Displays the CLI version to verify installation.
   - `gh auth status`: Confirms authentication status.
   - `gh repo list`: Lists repositories accessible via the authenticated token.
   - `gh workflow list`: Lists workflows in the current repository.

---

### Steps to Execute

1. **Set Up the Workflow**:

   - Place the `.github/workflows/misc-github-cli-integration.yml` file in your repository.

2. **Run the Workflow**:

   - Trigger the workflow manually using the `workflow_dispatch` event or by pushing changes to the workflow file.

3. **Review the Logs**:
   - Navigate to the **Actions** tab in your repository.
   - Check the logs for outputs from each runner environment.

---

### Expected Outputs

The GitHub CLI commands should produce the following outputs:

- **`gh --version`**: Confirms the installed version of the CLI.
- **`gh auth status`**: Verifies authentication using `GITHUB_TOKEN`.
- **`gh repo list`**: Lists all accessible repositories.
- **`gh workflow list`**: Lists the workflows available in the repository.

Example log output:

```plaintext
gh --version
gh version 2.0.0 (2024-12-03)

gh auth status
Logged in to github.com as username (GITHUB_TOKEN)

gh repo list
my-org/my-repo

gh workflow list
NAME                             ID     STATE     ...
build-and-test                   12345  active
```

---

### Additional Notes

- **Self-Hosted Runners**:

  - Ensure the GitHub CLI is installed and configured on the self-hosted runner.
  - Some commands like `env` might not work on certain environments (e.g., Windows).

- **Debugging**:
  - Use the `env` command to inspect environment variables where available.

By completing this lab, you'll have practical experience using the GitHub CLI within workflows to enhance automation capabilities.
