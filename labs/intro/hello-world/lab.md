## Lab: Manual Workflow

## Introduction

In this lab, you will create a manual workflow that can be triggered manually. The workflow will simply echo a message to the console, giving you a hands-on understanding of how manual workflows function in GitHub Actions.

> **Estimated Duration**: 15-20 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to the repository you created in the previous lab.
   - If you haven’t completed the previous lab, clone the template repository by following the instructions [here](./create-repository-using-template-repository-lab.md).

### Step 2: Create the manual workflow

1. Go to the **Actions** tab in your repository.
2. Click on the **New workflow** button.
3. From the list of workflow templates, select **Manual workflow**, and then click on **Configure**.
4. This will open the GitHub Actions workflow editor.

### Step 3: Add workflow content

1. In the workflow editor:

   - Name the workflow file `intro-manual-workflow.yml`.
   - Paste the following YAML content into the editor:

   ```yaml
   name: Intro - Manual Workflow

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/intro-manual-workflow.yml'

   jobs:
     run:
       runs-on: ubuntu-latest
       steps:
         - name: How's GitHub Actions?
           run: echo "Awesome!!"
   ```

2. Click the **Commit changes** button to save the workflow. This will create a new file `.github/workflows/intro-manual-workflow.yml` in your repository.

### Step 4: Understand the workflow

1. The workflow is named **Intro - Manual Workflow**.
2. It triggers on two events:
   - **`workflow_dispatch`**: This allows you to run the workflow manually.
   - **`push`**: The workflow will also run when changes are pushed to `.github/workflows/intro-manual-workflow.yml`.
3. The workflow uses the **`ubuntu-latest`** runner and contains a single job named **`run`** with one step that outputs the message: **`Awesome!!`**.

### Step 5: Run the workflow

1. Go back to the **Actions** tab. You should see the newly created workflow listed there.

   - If the workflow is not running, you can manually trigger it.

2. Click on the **Run workflow** button.

   - From the dropdown, select the **main** branch.
   - Click **Run workflow** to trigger the workflow.

3. Monitor the workflow execution.
   - You will see the workflow listed as running in the **Actions** tab.

### Step 6: View the results

1. Click on the workflow run to view its details.
2. Inside the workflow details page, click on the **run** job to view the job’s specifics.
3. Expand the step titled **How's GitHub Actions?** to view the output.
4. You should see the message **`Awesome!!`** displayed as the output of the step.

---

## Summary

In this lab, you created and ran a manual workflow in GitHub Actions. The workflow was triggered manually, ran a single job, and echoed a message to the console. This lab provided insight into how workflows are defined, triggered, and executed.

---

## Additional Resources

1. [GitHub Actions Documentation](https://docs.github.com/en/actions)
