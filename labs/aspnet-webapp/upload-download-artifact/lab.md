## Lab: Upload and Download Artifacts in GitHub Actions

## Introduction

In this lab, you will learn how to **upload** and **download** artifacts using GitHub Actions. You'll create a workflow with two jobs:

1. **Build and Upload** – Builds the ASP.NET Web App and uploads the publish output as an artifact.
2. **Download** – Downloads the artifact and lists its contents.

> **Estimated Duration**: 25–30 minutes
> **Prerequisites**: Your repo should have a sample ASP.NET Core Web App in `src/dotnet/WebApp`.

---

## Instructions

### Step 1: Set up your repository

1. Navigate to your repository on GitHub.
2. Ensure your ASP.NET Core Web App project is located at:
   `src/dotnet/WebApp`

   - If not present, scaffold a minimal web app using the following CLI:

     ```bash
     dotnet new webapp -o src/dotnet/WebApp
     ```

---

### Step 2: Create the workflow file

1. Go to your repository’s **Code** tab.

2. Click **Add file** > **Create new file**.

3. Enter the filename:
   `.github/workflows/aspnet-webapp-download-artifact.yml`

4. Paste the following content:

   ```yaml
   name: ASP.NET Web App - Upload Download Artifact

   on:
     push:
       paths:
         - '.github/workflows/aspnet-webapp-download-artifact.yml'
         - 'src/dotnet/WebApp/**'
     workflow_dispatch:

   jobs:
     build-and-upload:
       runs-on: ubuntu-latest
       defaults:
         run:
           working-directory: ./src/dotnet/WebApp
       steps:
         - name: Checkout Code
           uses: actions/checkout@v4.1.7

         - name: Set up .NET Core
           uses: actions/setup-dotnet@v4.0.1
           with:
             dotnet-version: '8.x'

         - name: Build Code
           run: dotnet build --configuration Release

         - name: Publish Code
           run: dotnet publish -c Release --property:PublishDir="${{runner.temp}}/webapp"

         - name: Upload Artifact
           uses: actions/upload-artifact@v4.3.6
           with:
             name: aspnet-web-app
             path: ${{runner.temp}}/webapp
             retention-days: 7

     download:
       runs-on: ubuntu-latest
       needs: build-and-upload
       steps:
         - name: Download Artifact
           uses: actions/download-artifact@v4.1.8
           with:
             name: aspnet-web-app

         - name: List Files in Artifact
           run: |
             ls -al
           shell: bash
   ```

5. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

- **Triggers**:

  - On push to the workflow or web app directory.
  - On manual execution via `workflow_dispatch`.

- **Job 1: `build-and-upload`**:

  - Checks out the code
  - Sets up .NET 8 SDK
  - Builds and publishes the ASP.NET app
  - Uploads the published app folder as an artifact

- **Job 2: `download`**:

  - Waits for Job 1 to complete
  - Downloads the uploaded artifact
  - Lists its contents using the `ls` command

---

### Step 4: Run and verify the workflow

1. Make a small change in any file under `src/dotnet/WebApp/` or the workflow file itself.
2. Push the changes to trigger the workflow.
3. Go to the **Actions** tab and select the workflow run.
4. Check that both jobs:

   - **build-and-upload** completes successfully and uploads the artifact.
   - **download** downloads the artifact and prints the file list.

---

### Step 5: View the uploaded artifact

1. In the **build-and-upload** job, scroll to the step **Upload Artifact**.
2. You should see a link to **aspnet-web-app**.
3. You can download it directly from there to inspect the contents manually if needed.

---

## Summary

In this lab, you:

- Created a two-job GitHub Actions workflow.
- Uploaded a build artifact using `actions/upload-artifact`.
- Downloaded the artifact in another job using `actions/download-artifact`.
- Verified artifact sharing between jobs in the same workflow.

This approach is useful when you want to reuse outputs between jobs, such as for deployment or analysis.

---

## Additional Resources

1. [Uploading artifacts - GitHub Docs](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts)
2. [Downloading artifacts - GitHub Docs](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts#downloading-artifacts)
3. [Publish in .NET CLI](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-publish)
