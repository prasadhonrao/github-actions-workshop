## Lab: Environment Variable Scope

## Introduction

In this lab, you will learn how to set environment variables at different scopes, including workflow, job, and step levels. You will also learn how to access these environment variables in your workflow.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a YAML Workflow Using the Starter File

1. Navigate to the [**Environment Variable Scope Starter File**](./env-var-scope-starter.md).

2. Copy the content of the starter file:

   ```yaml
   name: Env Var Scope

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-scope.yml'
   ```

3. In your repository, create a new workflow file under `.github/workflows` and name it `env-var-scope.yml`.

4. Paste the copied content into the new file.

5. Commit the workflow file to the `main` branch.

---

### Step 2: Add Environment Variable at Workflow Level

1. In the `env-var-scope.yml` file, define a new environment variable at the **workflow level** with the name `WORKFLOW_ENV_VAR` and the value `Workflow Environment Variable`.

---

### Step 3: Update the Workflow to Access and Print Environment Variables

1. Add a **job** to your workflow with the name `print`.

2. Inside the `print` job, define the **job-level** environment variable `JOB_ENV_VAR` and assign it the value `Job Environment Variable`.

   ```yaml
   jobs:
     print:
       runs-on: ubuntu-latest
       env:
         JOB_ENV_VAR: 'Job Environment Variable'
   ```

3. Add a **step** inside the `print` job and define the **step-level** environment variable `STEP_ENV_VAR` with the value `Step Environment Variable`.

4. In the step, print the values of the environment variables: `WORKFLOW_ENV_VAR`, `JOB_ENV_VAR`, and `STEP_ENV_VAR`.

   The final workflow should look like this:

   ```yaml
   steps:
     - name: Display Environment Variables
       env:
         STEP_ENV_VAR: 'Step Environment Variable'
       run: |
         echo "WORKFLOW_ENV_VAR: $WORKFLOW_ENV_VAR"
         echo "JOB_ENV_VAR: $JOB_ENV_VAR"
         echo "STEP_ENV_VAR: $STEP_ENV_VAR"
   ```

5. Final workflow should look like this:

   ```yaml
   name: Env Var Scope

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-scope.yml'

   env:
     WORKFLOW_ENV_VAR: 'Workflow Environment Variable'

   jobs:
     print:
       runs-on: ubuntu-latest
       env:
         JOB_ENV_VAR: 'Job Environment Variable'

       steps:
         - name: Display Environment Variables
           env:
             STEP_ENV_VAR: 'Step Environment Variable'
           run: |
             echo "WORKFLOW_ENV_VAR: $WORKFLOW_ENV_VAR"
             echo "JOB_ENV_VAR: $JOB_ENV_VAR"
             echo "STEP_ENV_VAR: $STEP_ENV_VAR"
   ```

---

### Step 4: Commit and Run the Workflow

1. Commit the changes to the `main` branch.

2. Go to the **Actions** tab in your repository and locate the **Env Var Scope** workflow.

3. Trigger the workflow manually by clicking on the **Run workflow** button.

4. Once the workflow runs, check the logs to see the printed values of the environment variables.

---

## Summary

Congratulations! You have successfully defined environment variables at different scopes (workflow, job, and step levels) and accessed them in your workflow. You've also learned how to print their values during the execution of the workflow.

---

## Additional Resources

- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Environment variables in GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/environment-variables)
- [Defining variables and secrets in workflows](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
