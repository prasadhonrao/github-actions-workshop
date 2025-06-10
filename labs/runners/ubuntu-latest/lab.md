## Lab: Runner - Ubuntu Latest

## Introduction

In this lab, you will create and execute a simple GitHub Actions workflow that runs on the `ubuntu-latest` GitHub-hosted runner. This lab demonstrates how to display operating system information and print custom messages from within a workflow.

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
   - Name the new file: `.github/workflows/runner-ubuntu-latest.yml`

3. Paste the following YAML content into the file:

   ```yaml
   name: Runner - Ubuntu Latest

   on: workflow_dispatch

   jobs:
     run:
       runs-on: ubuntu-latest
       steps:
         - run: echo "This is a message from ubuntu latest runner"
         - name: Display OS Information
           run: |
             uname -a
             lsb_release -a
   ```

4. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

1. **Workflow name**: `Runner - Ubuntu Latest`
2. **Trigger**: `workflow_dispatch` – this means the workflow must be triggered manually via the GitHub UI.
3. **Runner**: Uses GitHub-hosted `ubuntu-latest` environment.
4. **Steps**:

   - The first step prints a custom message.
   - The second step displays operating system information using `uname -a` and `lsb_release -a`.

---

### Step 4: Trigger the workflow manually

1. Go to the **Actions** tab in your repository.
2. Click on **Runner - Ubuntu Latest** from the workflow list.
3. Click the **Run workflow** button and confirm by clicking the green **Run workflow** button in the dropdown.

---

### Step 5: View the output

1. Once the workflow is running, click on the latest workflow run listed.
2. Click on the **run** job to expand it.
3. Review the logs for:

   - The custom echo message.
   - The OS and kernel details returned by `uname -a` and `lsb_release -a`.

---

## Summary

In this lab, you created a GitHub Actions workflow that runs on the `ubuntu-latest` runner and prints system-level details. This is useful for understanding the environment your GitHub Actions run in and for debugging platform-specific behavior.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub-Hosted Runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
- [lsb_release Manual](https://man7.org/linux/man-pages/man1/lsb_release.1.html)
