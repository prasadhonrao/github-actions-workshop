## Lab: Hello World Workflow

## Introduction

In this lab, you will create a simple GitHub Actions workflow from scratch that echoes "Hello, World!" to the console. This will help you understand how to define and trigger a basic workflow in GitHub Actions.

> **Estimated Duration**: 15–20 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to the repository you created in the previous lab.

   - If you haven’t completed the previous lab, clone the template repository by following the [instructions to clone the template repository](../template-repository/lab.md).

### Step 2: Create the workflow from scratch

1. In your repository, click the **Code** tab (if not already there).

2. Navigate to the `.github` folder. If it doesn't exist, create it:

   - Click **Add file** > **Create new file**.
   - Name the new folder: `.github/` (GitHub will treat it as a folder when followed by another folder or file).

3. Inside the `.github` folder, create a new folder named `workflows`:

   - Name the new file: `.github/workflows/intro-hello-world-workflow.yml`.

4. Paste the following YAML content into the editor:

   ```yaml
   name: Intro - Hello World Workflow

   on: push

   jobs:
     run:
       runs-on: ubuntu-latest
       steps:
         - name: Say Hello to the World
           run: echo "Hello, World!"
   ```

5. Scroll down and click the **Commit new file** button to save the workflow.

### Step 3: Understand the workflow

1. The workflow is named **Intro - Hello World Workflow**.
2. It is triggered by the `push` event, meaning it will run anytime you push changes to the repository.
3. It runs on the **ubuntu-latest** virtual machine.
4. It has a single job named **run**.
5. The job has one step that prints **"Hello, World!"** to the console.

### Step 4: Trigger the workflow

1. Make a small change in your repository to trigger the workflow (since it runs on `push`).

   - For example, edit the `README.md` file and add a comment line.
   - Commit the change to the `main` branch.

2. Go to the **Actions** tab.

   - You should see a new workflow run listed for **Intro - Hello World Workflow**.

### Step 5: View the results

1. Click on the workflow run to open its details.
2. Click on the **run** job.
3. Expand the step titled **Say Hello to the World**.
4. You should see the message **`Hello, World!`** in the logs.

---

## Summary

In this lab, you created a GitHub Actions workflow manually, without using any built-in templates. You learned how to define a basic workflow file, trigger it by pushing changes, and inspect its execution output.

---

## Additional Resources

1. [GitHub Actions Documentation](https://docs.github.com/en/actions)
