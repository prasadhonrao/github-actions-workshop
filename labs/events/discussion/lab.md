## Lab: Event - GitHub Discussions

## Introduction

In this lab, you will create a GitHub Actions workflow that is triggered whenever a new GitHub **Discussion** is created, edited, or deleted in your repository. This lab will help you understand how to use the `discussion` event and interact with its payload using `github.event`.

> **Estimated Duration**: 20–30 minutes

---

## Instructions

### Step 1: Enable Discussions in Your Repository

1. Navigate to your GitHub repository.
2. Click the **Settings** tab.
3. In the left sidebar, select **General**.
4. Scroll to the **Features** section.
5. Ensure the **Discussions** checkbox is checked.

> If the option is not available, make sure you have admin access to the repository.

---

### Step 2: Create the Workflow File

1. Navigate to the **Code** tab of your repository.
2. In the file explorer, create the following folder structure if it doesn't exist:

   - `.github/workflows/`

3. Inside the `workflows` folder, create a file named:
   `.github/workflows/discussion-event-workflow.yml`
4. Paste the following workflow content into the editor:

```yaml
name: Handle GitHub Discussion Events

on:
  discussion:
    types:
      [
        created,
        edited,
        deleted,
        pinned,
        unpinned,
        locked,
        unlocked,
        transferred,
        category_changed,
        answered,
        unanswered,
      ]

jobs:
  handle-discussion:
    runs-on: ubuntu-latest

    steps:
      - name: Print full event payload
        run: |
          echo "Full event payload:"
          echo "${{ toJSON(github.event) }}"

      - name: Print discussion metadata
        run: |
          echo "🗣️ Event Type: ${{ github.event.action }}"
          echo "📌 Title: ${{ github.event.discussion.title }}"
          echo "✍️ Author: ${{ github.event.discussion.user.login }}"
          echo "📝 Category: ${{ github.event.discussion.category.name }}"
          echo "💬 Body: ${{ github.event.discussion.body }}"

      - name: On Create
        if: github.event.action == 'created'
        run: echo "🎉 A new discussion was created!"

      - name: On Edit
        if: github.event.action == 'edited'
        run: echo "✏️ A discussion was edited!"

      - name: On Delete
        if: github.event.action == 'deleted'
        run: echo "🗑️ A discussion was deleted!"
```

5. Scroll down and click **Commit new file**.

---

### Step 3: Trigger the Workflow

1. Go to the **Discussions** tab of your repository.
2. Click **New discussion**.
3. Choose a category (e.g., General).
4. Enter a title and body.
5. Click **Start discussion** to trigger the `created` event.

You can also:

- **Edit** the discussion (click the `...` menu > Edit).
- **Delete** the discussion (click the `...` menu > Delete) to trigger other events.

---

### Step 4: View the Workflow Execution

1. Navigate to the **Actions** tab of your repository.
2. Select the run with the name **Handle GitHub Discussion Events**.
3. Click the **handle-discussion** job.
4. Expand the steps to view:

   - Event type and discussion details
   - Conditional messages depending on the event

---

## Supported `types` for the `discussion` Event

GitHub Actions supports the following activity types for the `discussion` event:

| Type               | Description                                 |
| ------------------ | ------------------------------------------- |
| `created`          | When a new discussion is created            |
| `edited`           | When the title or body is edited            |
| `deleted`          | When a discussion is deleted                |
| `pinned`           | When a discussion is pinned                 |
| `unpinned`         | When a discussion is unpinned               |
| `locked`           | When a discussion is locked                 |
| `unlocked`         | When a discussion is unlocked               |
| `transferred`      | When a discussion is moved between repos    |
| `category_changed` | When the category of the discussion changes |
| `answered`         | When a comment is marked as the answer      |
| `unanswered`       | When the answer status is removed           |

> 💡 **Note:** Adding or removing a **label** to a discussion does **not** trigger the `discussion` event.

## Summary

In this lab, you learned how to:

- Enable Discussions in a GitHub repository
- Create a GitHub Actions workflow triggered by the `discussion` event
- Inspect the event payload using `github.event`
- Use `if:` conditionals to branch logic depending on the discussion action

This lays the foundation for building more advanced automation workflows around GitHub Discussions (e.g., moderation, analytics, notifications).

---

## Additional Resources

1. [GitHub Actions - Events that trigger workflows](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows)
2. [GitHub Discussions Documentation](https://docs.github.com/en/discussions)
3. [Understanding the GitHub Actions Contexts](https://docs.github.com/en/actions/learn-github-actions/contexts)
