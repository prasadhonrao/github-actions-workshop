## Lab: Auto-Triage New Issue

## Introduction

In this lab, you will create a GitHub Actions workflow that automatically labels new issues and assigns them to a specified user (you). This automation is useful in real-world projects to reduce manual effort during issue triage and improve team responsiveness.

> **Estimated Duration**: 15–20 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to your GitHub repository.

   - You can use an existing repo or create a new one for this lab.

### Step 2: Create the workflow file

1. In the repository, go to the **Code** tab.

2. Click **Add file** > **Create new file**.

3. Name the file: `.github/workflows/auto-triage.yml`

   - This creates the workflow in the correct folder.

4. Paste the following content into the editor:

   ```yaml
   name: Auto-Triage Issues

   on:
     issues:
       types: [opened]

   jobs:
     auto-triage:
       runs-on: ubuntu-latest
       permissions:
         issues: write # Required to label and assign issues

       steps:
         - name: Add label and assign issue
           uses: actions/github-script@v7
           with:
             script: |
               const issueNumber = context.issue.number;
               const repo = context.repo.repo;
               const owner = context.repo.owner;

               await github.rest.issues.addLabels({
                 owner,
                 repo,
                 issue_number: issueNumber,
                 labels: ['triage']
               });

               await github.rest.issues.addAssignees({
                 owner,
                 repo,
                 issue_number: issueNumber,
                 assignees: ['your-github-username']
               });
   ```

5. **Important**: Replace `'your-github-username'` with your actual GitHub username (without quotes).

6. Scroll down and click **Commit new file**.

---

### Step 3: Understand the workflow

1. The workflow is named **Auto-Triage Issues**.
2. It is triggered by the `issues` event, specifically when a new issue is **opened**.
3. It uses the `github-script` action to:

   - Add a `triage` label to the new issue.
   - Assign the issue to you automatically.

---

### Step 4: Test the workflow

1. Go to the **Issues** tab of your repository.
2. Click **New issue**.
3. Fill in a title and description, then click **Submit new issue**.
4. Wait a few seconds, then refresh the page.

You should see:

- A label called `triage` added to the issue.
- The issue assigned to your GitHub account.

---

### Step 5: View the workflow run (optional)

1. Go to the **Actions** tab.
2. Click on the **Auto-Triage Issues** workflow.
3. Select the most recent run to see details of the execution.

   - You can expand the steps to see logs and confirm success.

---

## Summary

In this lab, you created a GitHub Actions workflow that automatically triages new issues by adding a label and assigning the issue to a specific user. This is a practical example of how GitHub Actions can be used to automate project management tasks and streamline team workflows.

---

## Additional Resources

1. [GitHub Actions Documentation](https://docs.github.com/en/actions)
2. [actions/github-script](https://github.com/actions/github-script)
