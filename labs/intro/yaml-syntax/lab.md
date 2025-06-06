## Lab: YAML Syntax

## Introduction

In this lab, you will explore the basics of **YAML syntax** and learn how it is used to define workflows in GitHub Actions. By analyzing and modifying a workflow file, you will understand key YAML structures such as lists, mappings, anchors, and flow control elements.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create a YAML Workflow Using the Starter File

1. Navigate to the [**YAML Syntax Starter File**](./intro-yaml-syntax-starter.md).
2. Copy the content of the starter file:

   ```yaml
   name: Intro - YAML Syntax

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/intro-yaml-syntax.yml'
   ```

3. In your repository, create a new workflow file under `.github/workflows` and name it `intro-yaml-syntax.yml`.
4. Paste the copied content into the new file.
5. Commit the workflow file to the `main` branch.

---

### Step 2: Enhance the Workflow with Job Definitions

1. Open the `intro-yaml-syntax.yml` file.
2. Replace the file’s content with the following YAML configuration:

   ```yaml
   name: YAML Syntax
   on:
     workflow_dispatch:
     push:
       branches:
         - main
   jobs:
     initial:
       runs-on: ubuntu-latest
       steps:
         - run: echo "This job will be run first."

     fanout1:
       runs-on: ubuntu-latest
       needs: initial
       steps:
         - run: echo "This job will run after the initial job, in parallel with fanout2."

     fanout2:
       runs-on: ubuntu-latest
       needs: initial
       steps:
         - run: echo "This job will run after the initial job, in parallel with fanout1."

     fanout3:
       runs-on: ubuntu-latest
       needs: fanout1
       steps:
         - run: echo "This job will run after the initial job, in parallel with fanout2."

     fanin:
       runs-on: ubuntu-latest
       needs: [fanout1, fanout2]
       steps:
         - run: echo "This job will run after fanout1 and fanout2 have finished."

     build:
       runs-on: ubuntu-latest
       strategy:
         matrix:
           configuration: [debug, release]
       steps:
         - run: echo "This job builds the configuration ${{ matrix.configuration }}."

     test:
       runs-on: ubuntu-latest
       needs: build
       steps:
         - run: echo "This job will be run after the build job."

     ring01:
       runs-on: ubuntu-latest
       needs: test
       steps:
         - run: echo "This job will be run after the test job."

     ring02:
       runs-on: macos-latest
       needs: test
       steps:
         - run: echo "This job will be run after the test job."

     ring03:
       runs-on: ubuntu-latest
       needs: test
       steps:
         - run: echo "This job will be run after the test job."

     ring04:
       runs-on: ubuntu-latest
       needs: [ring01, ring02, ring03]
       steps:
         - run: echo "This job will be run after the ring01, ring02, and ring03 jobs."

     prod:
       runs-on: ubuntu-latest
       needs: [ring04]
       steps:
         - run: echo "This job will be run after the ring04 job."
   ```

3. Commit the changes to the `main` branch.

---

### Step 3: Understand YAML Syntax and Workflow Structure

#### **Key Concepts in YAML**

- **Key-Value Pairs**:

  - YAML uses indentation to define a hierarchy.
  - For example:

    ```yaml
    name: YAML Syntax
    ```

  - `name` is the key, and `YAML Syntax` is its value.

- **Lists**:

  - YAML lists use `-` to indicate items.
  - Example:

    ```yaml
    branches:
      - main
    ```

- **Mappings**:

  - Use nested keys for defining structure:

    ```yaml
    jobs:
      initial:
        runs-on: ubuntu-latest
    ```

- **Anchor and Alias**:

  - Reduce duplication by referencing values:

    ```yaml
    common-steps: &default-steps
      - run: echo "Step reused!"
    ```

- **Multi-line Strings**:

  - Use `|` for multi-line values:

    ```yaml
    run: |
      echo "Line 1"
      echo "Line 2"
    ```

#### **Workflow Structure**

- **Triggers (`on`)**:

  - Defines when the workflow runs:
    - **`workflow_dispatch`**: Manual trigger.
    - **`push`**: Trigger on changes pushed to the repository.

- **Jobs and Dependencies**:

  - `needs` specifies the dependency chain.
  - Example: `fanin` depends on `fanout1` and `fanout2`.

- **Matrix Strategy**:

  - Allows running jobs with multiple configurations:

    ```yaml
    matrix:
      configuration: [debug, release]
    ```

---

### Step 4: Run the Workflow

1. Go to the **Actions** tab in your repository.
2. Manually trigger the workflow:
   - Click on the workflow name **YAML Syntax**.
   - Select **Run workflow** and choose the branch.
3. Monitor the progress of jobs and their dependencies.

---

### Step 5: View the Results

1. Inside the **Actions** tab, click on the workflow run to view its details.
2. Examine the execution order:
   - Note how jobs with dependencies (`needs`) are executed sequentially, while independent jobs run in parallel.
3. Explore the logs for each job to understand the output.

---

## Optional: Experiment with YAML

1. Add a new job to the workflow. For example:

   ```yaml
   experiment:
     runs-on: ubuntu-latest
     needs: fanout3
     steps:
       - run: echo "This job will run after fanout3."
   ```

2. Modify the matrix in the `build` job to include another configuration:

   ```yaml
   configuration: [debug, release, staging]
   ```

3. Commit the changes and observe the results in the **Actions** tab.

---

## Summary

In this lab, you:

1. Created a workflow using the **YAML Syntax Starter File**.
2. Enhanced the workflow by defining multiple jobs with dependencies.
3. Learned key YAML concepts such as key-value pairs, lists, and mappings.
4. Ran the workflow and reviewed its execution.

This lab provided a comprehensive introduction to YAML and its usage in defining GitHub workflows.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [YAML Syntax](https://yaml.org/spec/1.2/spec.html)
- [Workflow Dependencies](https://docs.github.com/en/actions/using-workflows/workflow-syntax-for-github-actions#needs)
