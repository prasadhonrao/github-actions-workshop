## Lab: Event - Discussion Comment

## Introduction

In this lab, you will create a GitHub Actions workflow that reacts when someone comments on a GitHub Discussion. You will also use the `contains` function to conditionally run logic based on the comment's content and demonstrate how to restrict workflow permissions for better security.

> **Estimated Duration**: 25–30 minutes

---

## Instructions

### Step 1: Prepare your repository

Ensure that GitHub Discussions is enabled in your repository:

1. Navigate to your repository on GitHub.
2. Click **Settings** > **General**.
3. Under **Features**, ensure **Discussions** is checked.

### Step 2: Create the workflow

1. In your repository, click the **Code** tab.

2. Create a new workflow file:

   - Path: `.github/workflows/event-discussion-comment.yml`
   - File content:

   ```yaml
   name: Event - Discussion Comment

   on:
     discussion_comment:
       types: [created]

   permissions:
     contents: read
     discussions: read

   jobs:
     check-comment:
       runs-on: ubuntu-latest
       steps:
         - name: Log comment
           run: echo "Comment: ${{ github.event.comment.body }}"

         - name: Check for keyword in comment
           if: contains(github.event.comment.body, 'urgent')
           run: echo "This comment is marked as URGENT!"

         - name: Check for unauthorized keyword
           if: contains(github.event.comment.body, 'shutdown')
           run: |
             echo "::warning::Detected sensitive keyword 'shutdown'. Manual review recommended."
   ```

3. Commit the file to the `main` branch.

---

### Step 3: Trigger the workflow

1. Go to the **Discussions** tab.
2. Open any existing discussion or create a new one.
3. Add a comment that contains the word `urgent` or `shutdown`.

Example comments:

- “This is **urgent**, please help!”
- “Should we **shutdown** the system?”

---

### Step 4: View the workflow output

1. Click the **Actions** tab.
2. Open the latest run of **Handle Discussion Comments**.
3. Review the logs under each step:

   - See the full comment body.
   - Observe if the `urgent` message is logged.
   - See a warning if `shutdown` is detected.

---

## Explanation of Key Concepts

### 1. `discussion_comment` Event

- Triggers the workflow when a **new comment** is added to a discussion.
- Supported `types`: `created`, `edited`, `deleted`.

### 2. `contains` Function

Used for conditional logic based on strings:

```yaml
if: contains(github.event.comment.body, 'urgent')
```

### 3. `permissions`

Restrict workflow token scope:

```yaml
permissions:
  contents: read
  discussions: read
```

This ensures the workflow can't modify content or discussions—only read access is allowed.

---

## Summary

In this lab, you created a workflow that responds to new discussion comments, uses conditional logic based on comment content, and demonstrates scoped GitHub token permissions. This sets the foundation for building more secure and context-aware workflows in collaborative projects.

---

## Additional Resources

- [GitHub Actions Events](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#discussion_comment)
- [Workflow expressions: `contains`](https://docs.github.com/en/actions/learn-github-actions/expressions#contains)
- [Workflow permissions](https://docs.github.com/en/actions/security-guides/automatic-token-authentication#permissions-for-the-github_token)
