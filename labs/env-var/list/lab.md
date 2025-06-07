## Lab: List Environment Variables

## Introduction

In this lab, you will learn how to display environment variables in Linux, macOS, and Windows operating systems using GitHub Actions.

GitHub Actions allows you to display environment variables in the logs. This can be useful for debugging purposes or to understand the environment in which your code is running. Please note that these environment variables are not secure and should not be used to store sensitive information. Additionally, they are case-sensitive.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a YAML Workflow Using the Starter File

1. Navigate to the [**Environment Variables List Starter File**](./env-var-list-starter.md).

2. Copy the content of the starter file:

   ```yaml
   name: Env Var List

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-list.yml'
   ```

3. In your repository, create a new workflow file under `.github/workflows` and name it `env-var-list.yml`.

4. Paste the copied content into the new file.

5. Commit the workflow file to the `main` branch.

---

### Step 2: Define Jobs to Display Environment Variables for Different OS

1. In the `env-var-list.yml` file, define three jobs: `ubuntu`, `mac`, and `windows`. These jobs will run the same task of displaying environment variables, but on different operating systems.

2. For each job, use the respective operating system as the `runs-on` value:

   - For Ubuntu, set `runs-on: ubuntu-latest`
   - For macOS, set `runs-on: macos-latest`
   - For Windows, set `runs-on: windows-latest`

3. Under each job, add a `steps` section to display the environment variables. The `printenv | sort` command will display environment variables for each operating system.

   The workflow should look like this:

   ```yaml
   name: Env Var List

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-list.yml'

   jobs:
     ubuntu:
       runs-on: ubuntu-latest
       steps:
         - name: Display Environment Variables on Ubuntu
           run: printenv | sort

     mac:
       runs-on: macos-latest
       steps:
         - name: Display Environment Variables on MacOS
           run: printenv | sort

     windows:
       runs-on: windows-latest
       steps:
         - name: Display Environment Variables on Windows
           run: printenv | sort
           shell: bash
   ```

---

### Step 3: Understanding the Workflow

1. **Name**: The `name` field defines the name of the workflow. In this case, it's set to `Env Var List`, which will be displayed in the Actions tab.

2. **Triggers**: The `on` field specifies the event that triggers the workflow. Here, the workflow is triggered either manually via `workflow_dispatch` or whenever changes are made to the `.github/workflows/env-var-list.yml` file.

3. **Jobs**: This workflow contains three jobs:

   - `ubuntu`: Runs on `ubuntu-latest`.
   - `mac`: Runs on `macos-latest`.
   - `windows`: Runs on `windows-latest`.

4. **Steps**: Each job has a `steps` section where commands are defined to display environment variables using the `printenv | sort` command. The `printenv` command lists all environment variables, and `sort` orders them alphabetically.

---

### Step 4: Commit the Workflow and Trigger It

1. Commit the changes to the `main` branch.

2. Go to your repository on GitHub, and navigate to the **Actions** tab.

3. Find the `Env Var List` workflow on the left sidebar.

4. Click on the **Run workflow** button, and select the `main` branch.

5. Click the **Run workflow** button to trigger the workflow.

---

### Step 5: Check the Workflow Run and View Environment Variables

1. Once the workflow runs, click on the **Display Environment Variables** job to see the logs for the three operating systems: Ubuntu, macOS, and Windows.

2. Review the logs to see the environment variables displayed for each operating system. You should notice some common environment variables shared across all operating systems, along with specific environment variables for each OS.

---

### Step 6: Use Matrix Strategy for Parallel Execution (Optional)

1. You can also use the matrix strategy to run the same job across multiple operating systems in parallel. This is useful for testing your code across different environments simultaneously.

2. Replace the three individual jobs with a matrix strategy in the workflow file:

   ```yaml
   name: Env Var List

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/env-var-list.yml'

   jobs:
     display-environment-variables:
       strategy:
         matrix:
           os: [ubuntu-latest, macos-latest, windows-latest]
       runs-on: ${{ matrix.os }}
       steps:
         - name: Display Environment Variables
           run: printenv | sort
           shell: bash
   ```

3. Commit the changes and rerun the workflow.

---

## Summary

Congratulations! You have successfully created a workflow to display environment variables on Ubuntu, macOS, and Windows using GitHub Actions. You have also learned how to use the matrix strategy to run the same job across multiple operating systems in parallel.

---

## Additional Resources

- [Workflow syntax for GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions)
- [Environment variables in GitHub Actions](https://docs.github.com/en/actions/reference/environment-variables)
- [Using the matrix strategy in GitHub Actions](https://docs.github.com/en/actions/using-workflows/using-a-matrix-for-your-jobs)
