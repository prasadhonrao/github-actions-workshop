## Lab: Scheduled Workflow

### Introduction

In this lab, you will create a scheduled workflow that runs at regular intervals using a cron expression. The workflow will also support manual triggering and will run when specific changes are pushed. This will help you understand how to configure workflows with schedules and additional triggers.

> **Estimated Duration**: 10-20 minutes

---

### Instructions

#### Step 1: Create the Workflow File

1. In your repository, create a new directory `.github/workflows` if it doesn’t exist.

2. Create a new workflow file named `intro-scheduled-workflow.yml` inside `.github/workflows`.

3. Add the following YAML content to the file to define the workflow name:

   ```yaml
   name: Intro - Scheduled Workflow
   ```

4. Save and commit the file to the `main` branch.

---

#### Step 2: Add Workflow Triggers

1. Open the `intro-scheduled-workflow.yml` file.

2. Add the following `on` section below the `name` field:

   ```yaml
   on:
     workflow_dispatch:
     schedule:
       - cron: '*/5 * * * *' # Every 5 minutes
     push:
       paths:
         - '.github/workflows/intro-scheduled-workflow.yml'
   ```

3. Commit the updated file.

---

#### Step 3: Add Workflow Jobs and Steps

1. Open the `intro-scheduled-workflow.yml` file again.

2. Add the following job definition below the triggers:

   ```yaml
   jobs:
     execute:
       runs-on: ubuntu-latest

       steps:
         - name: Display current date and time
           run: echo "The current date and time is $(date)"
   ```

3. Commit your changes.

---

#### Step 4: Run and Test the Workflow

- Wait for the scheduled run (every 5 minutes),
- Or manually trigger it from the **Actions** tab,
- Or commit a change to `.github/workflows/intro-scheduled-workflow.yml` to trigger it on push.

---

#### Step 5: View Workflow Results

- Go to the **Actions** tab,
- Click the latest workflow run,
- Open the **execute** job and expand the **Display current date and time** step to see the output.

---

#### Optional: Customize the Schedule

- Change the cron expression in the `schedule` section to run at different intervals,
- Commit your changes and observe the updated schedule.

---

### Summary

You created a scheduled GitHub Actions workflow from scratch, configured triggers for schedule, manual dispatch, and push events, added steps to the job, ran the workflow, and checked its output.
