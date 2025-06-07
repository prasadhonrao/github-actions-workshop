## Lab: Display Workflow Status Badge

## Introduction

In this lab, you will learn how to display the workflow status badge on a GitHub repository. The workflow status badge shows the status of the latest workflow run, making it easy to monitor the workflow status directly from the `README.md` file.

> **Duration**: 10-15 minutes

---

## Instructions

### Step 1: Navigate to Your GitHub Repository

1. Open your browser and go to your **GitHub repository** where the workflow is located.

---

### Step 2: Access the Actions Tab

1. In your repository, click on the **Actions** tab at the top of the page.

---

### Step 3: Choose a Workflow

1. Either create a new workflow or select an existing workflow from the list of workflows.
2. Make sure the workflow is saved and committed to the `.github/workflows/` directory.

---

### Step 4: Locate the Workflow for the Badge

1. In the **Actions** tab, find the workflow you want to display the status badge for.
2. Click on the workflow to open its page.

---

### Step 5: Create the Status Badge

1. On the workflow page, click on the **ellipsis (three dots)** menu located on the top-right of the page.
2. From the dropdown, select **"Create status badge."**

   GitHub will generate a Markdown snippet for the badge, which will look something like this:

   ```markdown
   ![Workflow Name](https://github.com/<OWNER>/<REPO>/actions/workflows/<WORKFLOW_FILE>.yml/badge.svg)
   ```

---

### Step 6: Update the Badge URL

1. Replace `<OWNER>`, `<REPO>`, and `<WORKFLOW_FILE>` in the URL with the appropriate values for your repository.

   - `<OWNER>`: Your GitHub username or organization name.
   - `<REPO>`: Your repository name.
   - `<WORKFLOW_FILE>`: The filename of the workflow (e.g., `workflow.yml`).

---

### Step 7: Edit the README.md File

1. Navigate to the **`README.md`** file in the root directory of your repository.
2. Click on the pencil icon (**Edit this file**) in the top-right corner.

---

### Step 8: Add the Badge to the README

1. Paste the copied badge Markdown snippet into the desired location within the `README.md` file. For example:

   ```markdown
   # Project Name

   ![Build Status](https://github.com/<OWNER>/<REPO>/actions/workflows/<WORKFLOW_FILE>.yml/badge.svg)

   ## Description

   A brief description of the project goes here.
   ```

---

### Step 9: Commit the Changes

1. After adding the badge, scroll to the bottom of the page.
2. Add a commit message like: `"Added GitHub Actions workflow status badge to README"`.
3. Choose either to commit directly to the `main` branch or create a new branch and open a pull request.
4. Click **"Commit changes"** or **"Propose changes"** to save your updates.

---

### Step 10: View the Badge in the Repository

1. Go back to the main page of the repository.
2. Open the `README.md` file, and you should see the workflow status badge displayed.
3. The badge will indicate the current status of the workflow, such as "passing" or "failing."

---

### Step 11: Example of Badge in README

Here’s an example of what the badge might look like in the `README.md`:

```markdown
# GitHub Actions Workshop

[![Intro - Simple Workflow](https://github.com/prasadhonrao/github-actions-workshop/actions/workflows/intro-simple-workflow.yml/badge.svg)](https://github.com/prasadhonrao/github-actions-workshop/actions/workflows/intro-simple-workflow.yml)

## About

GitHub Actions Workshop is designed to help you get started with GitHub Actions and learn how to use them to automate your software development workflow.
```

This is how the badge will appear in the `README.md` file:

[![Intro - Simple Workflow](https://github.com/prasadhonrao/github-actions-workshop/actions/workflows/intro-simple-workflow.yml/badge.svg)](https://github.com/prasadhonrao/github-actions-workshop/actions/workflows/intro-simple-workflow.yml)

You can click on the badge to navigate to the workflow page.

---

## Summary

Congratulations! You have successfully added a workflow status badge to your GitHub repository. The badge will automatically update whenever the workflow runs, showing the latest status.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Creating a status badge for your workflow](https://docs.github.com/en/actions/managing-workflow-runs/adding-a-workflow-status-badge)
