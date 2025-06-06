## Lab: Scheduled Workflow

## Introduction

In this lab, you will create a scheduled workflow that runs at regular intervals using a cron expression. The workflow will also support manual triggering and will run when specific changes are pushed. This will help you understand how to configure workflows with schedules and additional triggers.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a Scheduled Workflow Using the Starter File

1. Navigate to the [**Scheduled Workflow Starter File**](./intro-scheduled-workflow-starter.md).
2. Copy the content of the starter file:

   ```yaml
   name: Intro - Scheduled Workflow
   ```

3. In your repository, create a new workflow file under `.github/workflows` and name it `intro-scheduled-workflow.yml`.
4. Paste the copied content into the new file.
5. Commit the workflow file to the `main` branch.

---

### Step 2: Add Workflow Triggers

1. Open the `intro-scheduled-workflow.yml` file.
2. Add the following `on` section to define the workflow triggers:

   ```yaml
   on:
     workflow_dispatch:
     schedule:
       - cron: '*/5 * * * *' # Every 5 minutes
     push:
       paths:
         - '.github/workflows/intro-scheduled-workflow.yml'
   ```

3. Commit the updated workflow file to the `main` branch.
4. This configuration allows the workflow to:
   - **Run every 5 minutes** based on the cron expression.
   - **Run manually** using the `workflow_dispatch` trigger.
   - **Run when the file is modified** and committed to the repository.

---

### Step 3: Add Steps to the Workflow

1. Open the `intro-scheduled-workflow.yml` file again.
2. Add the following `jobs` section to define the tasks the workflow will perform:

   ```yaml
   jobs:
     execute:
       runs-on: ubuntu-latest

       steps:
         - name: Display current date and time
           run: echo "The current date and time is $(date)"
   ```

3. Commit the changes to the `main` branch.

---

### Step 4: Understanding the Workflow

The `intro-scheduled-workflow.yml` workflow includes the following sections:

#### **Name**

The workflow is named `Intro - Scheduled Workflow`.

#### **Trigger (`on`)**

- **`workflow_dispatch`**:
  - Allows manual triggering of the workflow from the **Actions** tab.
- **`schedule`**:
  - Runs the workflow automatically every 5 minutes based on the cron expression `*/5 * * * *`.
  - You can use tools like [crontab.guru](https://crontab.guru/) to generate and test cron expressions.
- **`push`**:
  - Runs the workflow when changes are made to the file `.github/workflows/intro-scheduled-workflow.yml`.

#### **Job (`jobs.execute`)**

- **`runs-on`**:

  - Specifies that the job will run on an `ubuntu-latest` GitHub-hosted runner.

- **Steps**:
  1. **Display Current Date and Time**:
     - Outputs the current date and time using the `date` command.

---

### Step 5: Run the Workflow

1. To test the workflow, you can:

   - Wait for the next scheduled run (every 5 minutes).
   - Trigger it manually from the **Actions** tab:
     - Select the workflow.
     - Click the **Run workflow** button and choose the branch to run.
   - Modify the file `.github/workflows/intro-scheduled-workflow.yml` and commit the changes to the `main` branch.

2. Monitor the workflow's progress in the **Actions** tab.

---

### Step 6: View the Results

1. Once the workflow has run, click on the workflow run to view its details.
2. Inside the workflow details page:
   - Click on the **execute** job to see the output.
   - Expand the step titled **Display current date and time** to view the output of the `date` command.
3. Verify that the displayed date and time correspond to the workflow execution time.

---

### Optional: Customize the Cron Expression

1. To schedule the workflow at a different frequency, update the `cron` value in the `schedule` section. For example:

   - **Every hour**: `0 * * * *`
   - **Every day at midnight**: `0 0 * * *`
   - **Every Monday at 9 AM**: `0 9 * * 1`

2. Commit the updated workflow to the `main` branch.

3. Test the new schedule by observing the next run.

---

## Summary

In this lab, you:

1. Created a workflow using the **Scheduled Workflow Starter File**.
2. Configured the workflow to run on a schedule, manually, and when specific changes are pushed.
3. Added a step to display the current date and time.
4. Ran the workflow and reviewed the output.

This lab demonstrated how to use scheduled workflows in GitHub Actions and customize triggers for automation.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Schedule Event](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#schedule)
- [Crontab Guru](https://crontab.guru/)
