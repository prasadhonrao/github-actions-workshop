## Lab: Automatically Comment and Label Issues

---

## Introduction

In this lab, you will create a workflow to automatically comment on new issues and add a label. This demonstrates how to use the `github-script` action for interacting with GitHub's REST API to enhance automation.

> **Estimated Duration**: 20-30 minutes

---

## Instructions

### Step 1: Create the Workflow File

1. Create a new workflow file in your repository under `.github/workflows/` named `auto-comment-on-issues.yml`.
2. Copy the following content into the workflow file:

   ```yaml
   name: Misc - Auto Comment on New Issue

   on:
     issues:
       types: opened
     workflow_dispatch:

   jobs:
     thanks:
       runs-on: ubuntu-latest
       permissions:
         issues: write # Required to create comments
       steps:
         - uses: actions/github-script@v7
           id: issue_script
           with:
             github-token: ${{ secrets.GITHUB_TOKEN }}
             script: |
               const issue_number = context.issue.number;
               console.log(`issue_number: ${issue_number}`);

               const owner = context.repo.owner;
               const repo = context.repo.repo;

               // Lookup issue info
               const issue = await github.rest.issues.get({
                 repo, owner, issue_number
               });
               console.log(`issue: ${issue}`);

               // Create comment thanking contributor
               const comment = await github.rest.issues.createComment({
                 repo, owner, issue_number,
                 body: "Thanks for your contribution!"
               });
               console.log(`comment id: ${comment.data.id}`);
               console.log(comment.data);

               // Auto-label the issue
               github.rest.issues.addLabels({
                 repo, owner, issue_number,
                 labels: ['todo-review']
               });

               // Make comment id available to subsequent steps
               return comment.data.id;

         - run: echo 'comment id=${{ steps.issue_script.outputs.result }}'
   ```

3. Commit the file to the `main` branch.

---

### Step 2: Trigger the Workflow

1. Open the **Issues** tab in your repository.
2. Create a new issue.
3. Wait a few moments for the workflow to run.
4. Navigate to the **Actions** tab and view the details of the workflow run.

---

### Step 3: Review the Workflow Functionality

1. **Comment**: The workflow should automatically add a comment to the newly created issue, thanking the contributor.
2. **Label**: The workflow should label the issue with `todo-review`.
3. **Logs**: Review the workflow logs to see the GitHub API interactions. Look for the issue number, comment ID, and other information logged by the script.

---

### Step 4: Understanding the Workflow

#### **Triggers (`on`)**

- **`issues`**:
  - Listens for the `opened` event when a new issue is created.
- **`workflow_dispatch`**:
  - Enables manual triggering of the workflow from the **Actions** tab.

#### **Jobs (`jobs`)**

- **`thanks`**:
  - Runs on `ubuntu-latest`.
  - Uses the `actions/github-script` action to interact with GitHub's REST API.

#### **Steps**

1. **Add Comment**:
   - The script fetches the issue number from the `context.issue` object.
   - It uses the GitHub REST API to create a comment on the issue, thanking the contributor.
2. **Add Label**:
   - The script adds a label (`todo-review`) to the issue using the GitHub REST API.
3. **Expose Comment ID**:
   - The script outputs the comment ID for potential use in subsequent steps.

---

### Step 5: Optional Enhancements

1. **Change the Comment Text**:

   - Modify the `body` field in the script to customize the comment text.

   ```javascript
   body: 'We appreciate your input! Stay tuned for a response.';
   ```

2. **Add Multiple Labels**:

   - Add additional labels by updating the `labels` array.

   ```javascript
   labels: ['todo-review', 'needs-feedback'];
   ```

3. **Trigger on Additional Events**:

   - Update the `on` section to include other issue-related events, such as `reopened`.

   ```yaml
   on:
     issues:
       types: [opened, reopened]
   ```

---

### Step 6: Run the Workflow Manually

If you want to test the workflow manually without creating a new issue:

1. Go to the **Actions** tab.
2. Select the workflow named **Misc - Auto Comment on New Issue**.
3. Click the **Run workflow** button.
4. Provide an issue number for testing if needed.

---

## Summary

In this lab, you:

1. Created a workflow that listens for new issue events.
2. Used the `github-script` action to comment on and label new issues.
3. Learned how to interact with the GitHub REST API through the GitHub Actions context.

This workflow is a practical example of automating repository management tasks with GitHub Actions.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub REST API Documentation](https://docs.github.com/en/rest)
- [github-script Action](https://github.com/actions/github-script)
