## Lab: Runner - Windows Latest

## Introduction

In this lab, you will create and execute a GitHub Actions workflow that runs on the `windows-latest` GitHub-hosted runner. This lab demonstrates how to display basic operating system information and print custom messages using a Windows environment.

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
   - Name the new file: `.github/workflows/runner-windows-latest.yml`

3. Paste the following YAML content into the file:

   ```yaml
   name: Runner - Windows Latest

   on: workflow_dispatch

   jobs:
     run:
       runs-on: windows-latest
       steps:
         - run: echo "This is a message from windows latest runner"
         - name: Display OS Information
           run: |
             systeminfo
   ```

4. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

1. **Workflow name**: `Runner - Windows Latest`
2. **Trigger**: `workflow_dispatch` – the workflow must be triggered manually.
3. **Runner**: Uses GitHub-hosted `windows-latest` environment.
4. **Steps**:

   - The first step prints a custom message using Windows PowerShell or Command Prompt.
   - The second step runs the `systeminfo` command to display OS details.

---

### Step 4: Trigger the workflow manually

1. Go to the **Actions** tab in your repository.
2. Click on **Runner - Windows Latest** from the workflow list.
3. Click the **Run workflow** button and confirm by clicking the green **Run workflow** button in the dropdown.

---

### Step 5: View the output

1. Once the workflow starts, click on the most recent run listed.
2. Click on the **run** job to expand it.
3. Review the logs for:

   - The custom echo message.
   - Detailed OS information such as OS version, system manufacturer, memory, and more from the `systeminfo` command.

---

## Summary

In this lab, you created and executed a GitHub Actions workflow that runs on the `windows-latest` runner. You used it to print system information and understand the characteristics of the Windows environment used by GitHub-hosted runners.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub-Hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
- [systeminfo Command Reference (Microsoft Docs)](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/systeminfo)
