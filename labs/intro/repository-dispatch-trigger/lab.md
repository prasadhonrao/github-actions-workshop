## Lab: `repository_dispatch` Trigger Workflow

## Introduction

In this lab, you will create a GitHub Actions workflow that is triggered by an HTTP POST request using the `repository_dispatch` event. This enables triggering workflows from external systems or scripts, making it a powerful way to integrate GitHub Actions with other tools and services.

> **Estimated Duration**: 20–30 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to the repository where you have workflow permissions.

   - You can use your existing repository or [clone a template repository](../template-repository/lab.md) if you don't already have one.

2. Make sure you have a **Personal Access Token (PAT)**. Use following steps to create one:

   > 💡 [Generate a PAT here](https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-a-repository-dispatch-event) and store it securely.

---

### Step 2: Create the workflow file

1. In your repository, go to the **Code** tab.

2. Navigate to or create the following path: `.github/workflows/`.

3. Inside this folder, create a new file named `intro-repository-dispatch-trigger.yml`.

4. Paste the following content into the file editor:

   ```yaml
   name: Intro - Repository Dispatch Trigger Workflow

   on:
     repository_dispatch:
       types: [trigger-from-api]

   jobs:
     echo:
       runs-on: ubuntu-latest
       steps:
         - name: Echo a message
           run: echo "This workflow was triggered via HTTP using repository_dispatch!"
   ```

5. Click **Commit new file** to save it to your repository.

---

### Step 3: Trigger the workflow using `curl`

1. Open a terminal or command prompt.

2. Run the following `curl` command to trigger the workflow via the GitHub REST API:

   ```bash
   curl -X POST \
     -H "Authorization: token YOUR_PERSONAL_ACCESS_TOKEN" \
     -H "Accept: application/vnd.github.v3+json" \
     https://api.github.com/repos/YOUR_USERNAME/YOUR_REPOSITORY/dispatches \
     -d '{"event_type":"trigger-from-api"}'
   ```

   Replace the following placeholders:

   - `YOUR_PERSONAL_ACCESS_TOKEN` → your GitHub token
   - `YOUR_USERNAME` → your GitHub username or organization
   - `YOUR_REPOSITORY` → the name of your repository

3. If successful, you will receive a `204 No Content` response.

---

### Step 4: View the results

1. Go to the **Actions** tab of your repository.

2. You should see a workflow run titled **Triggered from API**.

3. Click on the workflow run to open the details.

4. Expand the step named **Echo a message**.

5. You should see the output message:
   **`This workflow was triggered via HTTP using repository_dispatch!`**

---

## Summary

In this lab, you:

- Created a GitHub Actions workflow that listens for the `repository_dispatch` event.
- Triggered the workflow using an HTTP POST request via the GitHub REST API.
- Validated the workflow execution using the **Actions** tab.

This pattern is useful when integrating GitHub Actions into external systems, custom dashboards, or CI/CD pipelines.

---

## Additional Resources

1. [GitHub Actions Documentation](https://docs.github.com/en/actions)
2. [repository_dispatch Event Reference](https://docs.github.com/en/actions/using-workflows/events-that-trigger-workflows#repository_dispatch)
3. [GitHub REST API - Repository Dispatch](https://docs.github.com/en/rest/repos/repos#create-a-repository-dispatch-event)
4. [Creating a Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token)
