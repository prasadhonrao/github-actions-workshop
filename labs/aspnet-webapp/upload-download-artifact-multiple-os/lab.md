## Lab: ASP.NET Web App - Upload and Download Artifacts Across Multiple OS

## Introduction

In this lab, you will learn how to create a GitHub Actions workflow that uploads and downloads artifacts across multiple operating systems. You will configure a workflow to build an ASP.NET Core application on Windows, Ubuntu, and macOS, upload the generated artifacts, and then download and verify these artifacts.

> **Duration**: 30-45 minutes

---

## Prerequisites

1. Complete the [Create ASP.NET Web App](./create-aspnet-webapp-lab.md) lab to set up your ASP.NET Core project.
2. Ensure you have a basic understanding of GitHub Actions workflows, including uploading and downloading artifacts.

---

## Instructions

### Step 1: Create a New Workflow File

1. Open your project directory in **Visual Studio Code**.
2. Navigate to the `.github/workflows` directory in the root of your repository.
3. Create a new file named `upload-and-download-artifact-multiple-os.yml`.

---

### Step 2: Define Workflow Name and Trigger

1. Open the newly created file and define the workflow name and trigger conditions:

   ```yaml
   name: Upload and Download Artifact on Multiple Operating Systems

   on:
     push:
       paths:
         - '.github/workflows/upload-and-download-artifact-multiple-os.yml'
         - 'src/dotnet/WebApp/**'
     workflow_dispatch:
   ```

   - **`push` trigger**: Runs the workflow when changes are pushed to specific paths.
   - **`workflow_dispatch` trigger**: Allows you to manually trigger the workflow.

---

### Step 3: Add the Upload Job

1. Add a `jobs` section to define the `upload` job, which builds and uploads artifacts across multiple operating systems.
2. Use a **matrix strategy** to specify the OS:

   ```yaml
   jobs:
     upload:
       strategy:
         matrix:
           os: [ubuntu-latest, windows-latest, macos-latest]
       runs-on: ${{ matrix.os }}
       defaults:
         run:
           working-directory: ./src/dotnet/WebApp
           shell: bash
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
           run: |
             if [[ "$RUNNER_OS" == "Windows" ]]; then
               PUBLISH_DIR="${{ runner.temp }}\\webapp"
             else
               PUBLISH_DIR="${{ runner.temp }}/webapp"
             fi

             mkdir -p "$PUBLISH_DIR"
             dotnet publish -c Release --output "$PUBLISH_DIR"
             ls "$PUBLISH_DIR"

         - name: Upload Artifact
           uses: actions/upload-artifact@v4.3.6
           with:
             name: '.net-web-app-${{ runner.os }}'
             path: ${{ runner.temp }}/webapp
   ```

   - **Matrix strategy**: Executes the job for all three operating systems.
   - **Dynamic artifact names**: Includes the OS in the artifact name for easy identification.

---

### Step 4: Add the Download Job

1. Add the `download` job to retrieve the uploaded artifacts and verify them:

   ```yaml
   download:
     strategy:
       matrix:
         os: [ubuntu-latest, windows-latest, macos-latest]
     runs-on: ${{ matrix.os }}
     needs: upload
     defaults:
       run:
         shell: bash
     steps:
       - name: Download Artifact
         uses: actions/download-artifact@v4.1.8
         with:
           name: '.net-web-app-${{ runner.os }}'

       - name: List Downloaded Files
         run: ls -R ./downloaded-artifacts

       - name: Verify Artifact Content
         run: echo "Downloaded artifact verified successfully."
   ```

   - **`needs` keyword**: Ensures the `download` job runs only after the `upload` job completes.
   - **Listing files**: Provides visual confirmation of downloaded artifact contents.

---

### Step 5: Save and Push Changes

1. Save the file and commit your changes with a descriptive message, e.g., `"Add workflow for artifact upload and download on multiple OS"`.
2. Push the changes to your GitHub repository.

---

### Step 6: Run and Monitor the Workflow

1. Navigate to the **Actions** tab in your GitHub repository.
2. Select the **Upload and Download Artifact on Multiple Operating Systems** workflow.
3. Trigger the workflow manually using the **Run workflow** button or push a change to a monitored path.

---

### Step 7: Verify Uploaded and Downloaded Artifacts

1. After the workflow completes:
   - Open the `upload` job summary and confirm that artifacts are uploaded successfully for all operating systems.
   - Review the `download` job logs to ensure artifacts were downloaded and listed correctly.
2. Download the artifacts from the **Artifacts** section on the workflow summary page and inspect them locally to verify their contents.

---

## Summary

In this lab, you created a GitHub Actions workflow to upload and download artifacts across multiple operating systems. You used matrix strategies to build and publish your ASP.NET Core application for Windows, Ubuntu, and macOS. Finally, you verified the workflow by downloading and inspecting the artifacts.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [GitHub Actions: Upload Artifact](https://docs.github.com/en/actions/guides/storing-workflow-data-as-artifacts)
- [GitHub Actions: Download Artifact](https://docs.github.com/en/actions/guides/downloading-workflow-artifacts)
