## Lab: Runner - Self-Hosted

## Introduction

In this lab, you will create and execute a GitHub Actions workflow that runs on a **self-hosted** runner. This lab demonstrates how to print custom messages and gather system-level information from your own environment. Self-hosted runners give you full control over the hardware and software your workflows run on.

> **Estimated Duration**: 20–30 minutes (includes setup if self-hosted runner is not yet configured)

---

## Prerequisites

- A self-hosted runner must be configured and registered with your repository or organization.
- The self-hosted machine must be online and capable of executing workflows (Windows in this example).

> 📘 [Learn how to add a self-hosted runner](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners)

---

## Instructions

### Step 1: Set up your repository

1. Navigate to your GitHub repository where you want to create the workflow.
2. If you don’t have one, create a new repository by clicking **+** > **New repository**.

---

### Step 2: Create the workflow file

1. In the repository, click the **Code** tab.

2. Navigate to the `.github/workflows/` directory.

   - If the directory doesn’t exist, create it.
   - Then click **Add file** > **Create new file** and name it: `.github/workflows/runner-self-hosted.yml`

3. Paste the following YAML content into the editor:

   ```yaml
   name: Runner - Self Hosted

   on: workflow_dispatch

   jobs:
     run:
       runs-on: self-hosted
       steps:
         - run: echo "This is a message from self hosted runner"
         - name: Display OS Information
           run: |
             systeminfo
   ```

4. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

1. **Workflow name**: `Runner - Self Hosted`
2. **Trigger**: `workflow_dispatch` – it must be triggered manually.
3. **Runner**: Executes on a machine tagged as `self-hosted`.
4. **Steps**:

   - Echoes a custom message.
   - Runs the `systeminfo` command to print operating system details (Windows environment expected).

---

### Step 4: Trigger the workflow manually

1. Go to the **Actions** tab in your repository.
2. Click on **Runner - Self Hosted** in the workflow list.
3. Click the **Run workflow** button and confirm to trigger it.

---

### Step 5: View the output

1. Once the run starts, click the most recent execution.
2. Expand the **run** job to view the logs:

   - You should see the custom message.
   - You’ll also see system details such as OS version, RAM, processor info, and more from `systeminfo`.

> 📝 If the workflow stays queued or fails to find a runner, ensure your self-hosted runner is properly configured and online.

---

## Summary

In this lab, you created and executed a GitHub Actions workflow on a **self-hosted** runner. This allowed you to access local system resources and have greater control over the runtime environment compared to GitHub-hosted runners.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Adding Self-Hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners/adding-self-hosted-runners)
- [systeminfo Command (Microsoft Docs)](https://learn.microsoft.com/en-us/windows-server/administration/windows-commands/systeminfo)
