## Lab: Runner - MacOS Latest

## Introduction

In this lab, you will create and execute a GitHub Actions workflow that runs on the `macos-latest` GitHub-hosted runner. This lab demonstrates how to display macOS operating system information and print a custom message.

> **Estimated Duration**: 15–20 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to your GitHub repository where you want to create the workflow.

   - If you don’t have a repository yet, create a new one by clicking **+** > **New repository**.

### Step 2: Create the workflow file

1. In your repository, click the **Code** tab (if not already there).

2. Navigate to the `.github` folder. If it doesn't exist:

   - Click **Add file** > **Create new file**
   - Name the new file: `.github/workflows/runner-macos-latest.yml`

3. Paste the following YAML content into the file:

   ```yaml
   name: Runner - MacOS Latest

   on: workflow_dispatch

   jobs:
     run:
       runs-on: macos-latest
       steps:
         - run: echo "This is a message from MacOS latest runner"
         - name: Display OS Information
           run: |
             system_profiler SPSoftwareDataType
   ```

4. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

1. **Workflow name**: `Runner - MacOS Latest`
2. **Trigger**: `workflow_dispatch` – the workflow must be manually triggered.
3. **Runner**: Uses GitHub-hosted `macos-latest` virtual environment.
4. **Steps**:

   - The first step prints a custom message.
   - The second step runs `system_profiler SPSoftwareDataType` to display macOS version and system details.

---

### Step 4: Trigger the workflow manually

1. Go to the **Actions** tab in your repository.
2. Click on **Runner - MacOS Latest** from the workflow list.
3. Click the **Run workflow** button and confirm the action.

---

### Step 5: View the output

1. Once the workflow is running, click on the latest run listed.
2. Click on the **run** job to view details.
3. Expand the logs to see:

   - The custom echo message.
   - System details such as macOS version, build, and kernel version from `system_profiler`.

---

## Summary

In this lab, you created and executed a GitHub Actions workflow using the `macos-latest` runner. You used this environment to print system information, helping you understand what operating system is used when running jobs on GitHub's macOS runners.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub-Hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
- [system_profiler Command Reference](https://ss64.com/osx/system_profiler.html)
