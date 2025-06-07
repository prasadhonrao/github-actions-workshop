## Lab: ASP.NET Web API Build

## Introduction

In this lab, you will learn how to build a ASP.NET Web API using GitHub Actions. You will create a workflow that builds the api on an Ubuntu runner.

> **Duration**: 15-20 minutes

---

## Prerequisites

Before starting this lab, ensure that you have completed the [Create ASP.NET Web API](./create-aspnet-webapi-lab.md) lab to have your ASP.NET Web API ready for this lab.

---

## Instructions

### Step 1: Create a YAML Workflow Using the Starter File

1. In your repository, create a new file under `.github/workflows` and name it `aspnet-webapi-build.yml`.
2. Commit the changes and push the workflow file to the `main` branch.

---

### Step 2: Define the Workflow Name and Event Triggers

1. In the `aspnet-webapi-build.yml` file, define the name of the workflow and the events that will trigger it. Use the following code to trigger the workflow on a push to specific files or manually using `workflow_dispatch`.

   ```yaml
   name: ASP.NET Web API Build
   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/aspnet-webapi-build.yml'
         - 'src/dotnet/Weather.WebApi/**'
   ```

2. This ensures that the workflow will run when changes are made to the `aspnet-webapi-build.yml` file or to the application code under `src/dotnet/Weather.WebApi/`.

---

### Step 3: Add the Build Job

1. Below the `on` section, define the job that will run the build process. This job will run on an `ubuntu-latest` runner and will include the necessary steps for building and publishing the application.
2. Add the following steps to the `build` job:

   ```yaml
   jobs:
     build:
     runs-on: ubuntu-latest
     steps:
      - name: Checkout code
       uses: actions/checkout@v4.1.7

      - name: Set up .NET Core
       uses: actions/setup-dotnet@v4.0.1
       with:
        dotnet-version: '8.x'

      - name: Build code
       run: dotnet build --configuration Release
   ```

---

### Step 4: Understanding the Workflow

1. The workflow contains a single job named `build` that runs on an `ubuntu-latest` runner.

2. The job has four key steps:
   - **Checkout code**: This step uses the `actions/checkout` action to retrieve the latest code from the repository.
   - **Set up .NET Core**: The `actions/setup-dotnet` action installs the required version of the .NET SDK (`8.x` in this case) to the runner.
   - **Build code**: This step compiles the application using `dotnet build` in **Release** configuration.

---

### Step 5: Commit and Push the Workflow File

1. Save and commit the changes to the `aspnet-webapi-build.yml` file in your repository.
2. Push the changes to the repository.

---

### Step 6: View the Workflow Runs

1. Go to the **Actions** tab in your GitHub repository.
2. You should see the latest workflow run triggered by the push you just made.
3. Click on the latest workflow run to view the details.

---

### Step 7: Review the Logs

1. Click on the **build** job within the workflow run to expand it.
2. Review the logs for each step to ensure the build and publish process ran successfully.

---

## Summary

In this lab, you created a GitHub Actions workflow to build an ASP.NET Core Web API using an Ubuntu runner. You used the `actions/setup-dotnet` action to install the necessary .NET Core SDK, then built and published the API. Additionally, you learned how the workflow is structured, how it is triggered, and how to monitor the workflow runs in GitHub Actions.
