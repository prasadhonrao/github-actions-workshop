## Lab: Introduction to Reusable Workflows

---

## Objective

In this lab, you will learn how to create and use **reusable workflows** in GitHub Actions. A reusable workflow enables modularity by defining common steps in one workflow that can be invoked by other workflows.

This lab covers:

1. Creating a reusable workflow.
2. Defining a caller workflow to invoke the reusable workflow.

> **Duration**: 20-30 minutes

---

## Prerequisites

1. **GitHub Repository**: Ensure you have access to a repository where you can create workflows.
2. **Basic Knowledge of YAML**: Familiarity with GitHub Actions workflow syntax is beneficial.

---

## Instructions

### Step 1: Create a Reusable Workflow

1. **Navigate to Your Repository**:

   - Open your GitHub repository in **Visual Studio Code** or your preferred IDE.

2. **Create the Workflow File**:

   - In the `.github/workflows` directory, create a new file named `reusable-workflow-echo.yml`.

3. **Define the Reusable Workflow**:

   - Add the following YAML code:

     ```yaml
     name: Reusable Workflow Echo
     on:
       workflow_call:
         inputs:
           my-input:
             required: true
             type: string
     jobs:
       echo:
         runs-on: ubuntu-latest
         steps:
           - name: Echo input
             run: echo ${{ inputs.my-input }}
     ```

   #### Explanation

   - **`workflow_call`**: Specifies that this is a reusable workflow.
   - **`inputs`**: The `my-input` parameter is required and will accept a string.
   - **Job `echo`**: Runs on an Ubuntu environment and echoes the provided input.

4. **Commit the Workflow**:

   - Save and commit the file:

     ```bash
     git add .github/workflows/reusable-workflow-echo.yml
     git commit -m "Add reusable workflow"
     git push
     ```

---

### Step 2: Create a Caller Workflow

1. **Create the Workflow File**:

   - In the `.github/workflows` directory, create another file named `reusable-workflow-echo-caller.yml`.

2. **Define the Caller Workflow**:

   - Add the following YAML code:

     ```yaml
     name: Reusable Workflow Echo Caller

     on:
       workflow_dispatch:
       push:
         paths:
           - '.github/workflows/reusable-workflow-echo-caller.yml'
     jobs:
       call:
         uses: ./.github/workflows/reusable-workflow-echo.yml
         with:
           my-input: 'Hello, world!'
     ```

   #### Explanation

   - **`workflow_dispatch`**: Allows manual execution of this workflow.
   - **`push`**: Automatically triggers the workflow if changes are made to the caller workflow file.
   - **`uses`**: Calls the reusable workflow `reusable-workflow-echo.yml`.
   - **`with`**: Supplies the required input `my-input` with the value `'Hello, world!'`.

3. **Commit the Caller Workflow**:

   - Save and commit the file:

     ```bash
     git add .github/workflows/reusable-workflow-echo-caller.yml
     git commit -m "Add reusable workflow caller"
     git push
     ```

---

### Step 3: Trigger and Verify the Workflows

1. **Manually Trigger the Caller Workflow**:

   - Navigate to the **Actions** tab in your GitHub repository.
   - Select the `Reusable Workflow Echo Caller` workflow.
   - Click **Run workflow** to manually trigger it.

2. **View the Output**:

   - Open the workflow run details.
   - Look for the `Echo input` step under the `call` job.
   - Verify that the output is:

     ```plaintext
     Hello, world!
     ```

3. **Modify the Input Parameter**:

   - Edit the `reusable-workflow-echo-caller.yml` file:

     ```yaml
     with:
       my-input: 'Reusable workflows are powerful!'
     ```

   - Commit and push the changes:

     ```bash
     git add .github/workflows/reusable-workflow-echo-caller.yml
     git commit -m "Update input parameter"
     git push
     ```

4. **Re-trigger the Workflow**:
   - Navigate to the **Actions** tab and rerun the `Reusable Workflow Echo Caller` workflow.
   - Verify the new input value is echoed in the logs.

---

## Summary

In this lab, you have learned how to:

- Create a reusable workflow with input parameters.
- Call the reusable workflow using a caller workflow.
- Pass dynamic parameters from the caller to the reusable workflow.

Reusable workflows help improve the modularity, maintainability, and scalability of your CI/CD pipelines.

---

## Additional Resources

- [Reusable Workflows in GitHub Actions](https://docs.github.com/en/actions/using-workflows/reusing-workflows)
- [GitHub Actions Workflow Syntax](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions)
