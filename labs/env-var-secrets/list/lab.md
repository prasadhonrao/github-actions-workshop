## Lab: List Environment Variables

## Introduction

In this lab, you will learn how to display environment variables in Linux, macOS, and Windows operating systems using GitHub Actions.

GitHub Actions allows you to display environment variables in the logs. This can be useful for debugging purposes or to understand the environment in which your code is running. Please note that these environment variables are not secure and should not be used to store sensitive information. Additionally, they are case-sensitive.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a YAML Workflow File

1. In your repository, create a directory `.github/workflows` if it doesn't exist.

2. Inside `.github/workflows`, create a new file named `env-var-list.yml`.

3. Add the following content to `env-var-list.yml`:

   ```yaml
   name: Env Var List

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-list.yml'

   jobs:
     ubuntu:
       runs-on: ubuntu-latest
       steps:
         - name: Display Environment Variables on Ubuntu
           run: printenv | sort

     mac:
       runs-on: macos-latest
       steps:
         - name: Display Environment Variables on MacOS
           run: printenv | sort

     windows:
       runs-on: windows-latest
       steps:
         - name: Display Environment Variables on Windows
           run: printenv | sort
           shell: bash
   ```

4. Commit the file to the `main` branch.

---

### Step 2: Understanding the Workflow

1. **Name**: The workflow is named `Env Var List`.
2. **Triggers (`on`)**:

   - `workflow_dispatch` enables manual triggering from GitHub Actions tab.
   - `push` triggers when `env-var-list.yml` changes.

3. **Jobs**:

   - `ubuntu` runs on `ubuntu-latest`.
   - `mac` runs on `macos-latest`.
   - `windows` runs on `windows-latest`.

4. **Steps**: Each job runs `printenv | sort` to display environment variables in alphabetical order.

---

### Step 3: Commit and Trigger the Workflow

1. After committing, go to the **Actions** tab in your GitHub repository.
2. Select the `Env Var List` workflow.
3. Click the **Run workflow** button.
4. Choose the `main` branch and click **Run workflow** to start.

---

### Step 4: View Workflow Results

1. Once the workflow completes, open the run details.
2. Click on each job (`ubuntu`, `mac`, `windows`) to view their logs.
3. Expand the step named **Display Environment Variables** to see the output for each operating system.

---

### Step 5: (Optional) Use a Matrix Strategy for Parallel Execution

You can simplify the workflow using a matrix to run jobs in parallel on all three OSes:

```yaml
jobs:
  display-environment-variables:
    strategy:
      matrix:
        os: [ubuntu-latest, macos-latest, windows-latest]
    runs-on: ${{ matrix.os }}
    steps:
      - name: Display Environment Variables
        run: printenv | sort
        shell: bash
```

1. Replace the `jobs` section with the above.
2. Commit and rerun the workflow.

---

## Summary

You created a workflow file from scratch, configured jobs on Ubuntu, macOS, and Windows runners, displayed environment variables, triggered workflows manually and on push, and optionally used a matrix strategy for cleaner parallel execution.

---

## Additional Resources

- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions)
- [Environment variables in GitHub Actions](https://docs.github.com/en/actions/reference/environment-variables)
- [Using the matrix strategy in GitHub Actions](https://docs.github.com/en/actions/using-workflows/using-a-matrix-for-your-jobs)
