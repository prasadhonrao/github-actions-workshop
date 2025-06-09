## Lab: Environment Variable Scope

## Introduction

In this lab, you will learn how to set environment variables at different scopes, including workflow, job, and step levels. You will also learn how to access these environment variables in your workflow.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a YAML Workflow File

1. In your repository, create a directory `.github/workflows` if it doesn't exist.

2. Inside `.github/workflows`, create a new file named `env-var-scope.yml`.

3. Add the following initial content to the file:

   ```yaml
   name: Env Var Scope

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-scope.yml'
   ```

4. Commit the file to the `main` branch.

---

### Step 2: Add Environment Variable at Workflow Level

1. Edit `env-var-scope.yml` and add a workflow-level environment variable called `WORKFLOW_ENV_VAR` with the value `Workflow Environment Variable`:

   ```yaml
   env:
     WORKFLOW_ENV_VAR: 'Workflow Environment Variable'
   ```

---

### Step 3: Update the Workflow to Access and Print Environment Variables

1. Add a job named `print` that runs on `ubuntu-latest`.
2. Define a job-level environment variable `JOB_ENV_VAR` with value `Job Environment Variable`.
3. Add a step in the job where you define a step-level environment variable `STEP_ENV_VAR` with value `Step Environment Variable`.
4. Print the values of all three environment variables (`WORKFLOW_ENV_VAR`, `JOB_ENV_VAR`, and `STEP_ENV_VAR`).

The final workflow should look like this:

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
2. In GitHub, go to the **Actions** tab and select the **Env Var Scope** workflow.
3. Click **Run workflow** and choose the `main` branch.
4. After the workflow runs, review the logs to see the printed environment variable values.

---

## Summary

Congratulations! You have successfully defined environment variables at different scopes (workflow, job, and step levels) and accessed them in your workflow. You have also learned how to print their values during workflow execution.

---

## Additional Resources

- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions)
- [Environment variables in GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/environment-variables)
- [Defining variables and secrets in workflows](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
