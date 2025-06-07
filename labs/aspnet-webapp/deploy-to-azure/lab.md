## Lab: ASP.NET Web App Deploy to Azure

## Objective

In this lab, you will learn how to create a GitHub Actions workflow to build and deploy an ASP.NET web application to Azure. The workflow will automatically trigger when changes are pushed to the `src/dotnet/WebApp` directory and will deploy the web app to an Azure App Service.

> Duration: 30-45 minutes

---

Certainly! Here's the updated **Prerequisites** section with the new point related to creating an ASP.NET Web App:

---

## Prerequisites

1. **GitHub Repository**: Ensure that your repository has an ASP.NET web application located in the `src/dotnet/WebApp` directory.
2. **Create an ASP.NET Web App**: If you don't have an existing ASP.NET web app, you can create one using the steps mentioned in the [Create ASP.NET Web App](./../create-webapp/lab.md) lab.

---

## Instructions

### Step 1: Open the GitHub Actions Workflow File

1. Open the `GitHub Actions` repository in **Visual Studio Code** or your preferred IDE.
2. Go to the `.github/workflows` directory and create a new file named `aspnet-webapp-deploy.yml`.

### Step 2: Define the Workflow Trigger

1. Add the following YAML code to define the workflow trigger. The workflow will run automatically on a `push` event when there are changes to the `src/dotnet/WebApp` directory or when manually triggered (`workflow_dispatch`).

   ```yaml
   name: ASP.NET Web App Deploy

   on:
     push:
       paths:
         - '.github/workflows/aspnet-webapp-deploy.yml'
         - 'src/dotnet/WebApp/**'

   env:
     AZURE_WEBAPP_NAME: github-actions-workshop-aspnet-webapp
     AZURE_WEBAPP_PACKAGE_PATH: ./published
     CONFIGURATION: Release
     DOTNET_CORE_VERSION: 8.0.x
     WORKING_DIRECTORY: 'src/dotnet/WebApp'
   ```

   This configuration ensures the workflow will be triggered when there are changes in the `src/dotnet/WebApp` directory or if the workflow file itself is modified.

### Step 3: Define the Build Job

1. Add the following code to define the `build` job that will run on the `ubuntu-latest` runner. This job will build and publish the ASP.NET web app.

   ```yaml
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - uses: actions/checkout@v4
         - name: Setup .NET SDK
           uses: actions/setup-dotnet@v4
           with:
             dotnet-version: ${{ env.DOTNET_CORE_VERSION }}
         - name: Verify Working Directory
           run: |
             echo "Current Directory: $(pwd)"
             ls ${{ env.WORKING_DIRECTORY }}
         - name: Restore dependencies
           run: dotnet restore ${{ env.WORKING_DIRECTORY }}
         - name: Build
           run: dotnet build "${{ env.WORKING_DIRECTORY }}" --configuration ${{ env.CONFIGURATION }} --no-restore
         - name: Publish
           run: dotnet publish "${{ env.WORKING_DIRECTORY }}" --configuration ${{ env.CONFIGURATION }} --output "${{ env.AZURE_WEBAPP_PACKAGE_PATH }}"
         - name: Publish Artifacts
           uses: actions/upload-artifact@v4
           with:
             name: webapp
             path: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }}
   ```

   **Explanation**:

   - The `actions/checkout` step checks out the code.
   - The `actions/setup-dotnet` action sets up the .NET SDK environment.
   - The `dotnet restore` step restores any dependencies for the app.
   - The `dotnet build` command builds the app in `Release` configuration.
   - The `dotnet publish` step publishes the app to the output directory (`./published`).
   - The `actions/upload-artifact` step uploads the published output as an artifact for later use in the deployment job.

### Step 4: Define the Deploy Job

1. Below the build job, define the `deploy` job. This job will deploy the artifact from the build job to the Azure App Service.

   ```yaml
   deploy:
     runs-on: ubuntu-latest
     needs: build
     steps:
       - name: Download artifact from build job
         uses: actions/download-artifact@v4
         with:
           name: webapp
           path: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }}
       - name: Azure Login
         uses: azure/login@v2
         with:
           creds: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}
       - name: Deploy to Azure WebApp
         uses: azure/webapps-deploy@v2
         with:
           app-name: ${{ env.AZURE_WEBAPP_NAME }}
           package: ${{ env.AZURE_WEBAPP_PACKAGE_PATH }}
   ```

   **Explanation**:

   - The `actions/download-artifact` step downloads the published artifact from the build job.
   - The `azure/login` action authenticates the workflow to Azure using a service principal stored in the GitHub secrets.
   - The `azure/webapps-deploy` action deploys the web app to the Azure App Service using the package from the build job.

### Step 5: Commit and Push Changes

1. After adding the workflow file, commit the changes to your repository.

   ```bash
   git add .github/workflows/aspnet-webapp-deploy.yml
   git commit -m "Add ASP.NET Web App Build and Deploy Workflow"
   git push
   ```

### Step 6: Trigger the Workflow

1. Once you push the changes to the repository, the workflow will automatically trigger when you push changes to the `src/dotnet/WebApp` directory.
2. You can also manually trigger the workflow from the **Actions** tab in your GitHub repository by selecting the workflow and clicking the **Run workflow** button.

### Step 7: Verify the Deployment

1. Check the **Actions** tab in GitHub to see the status of the workflow.
2. Once the workflow completes, you should see the ASP.NET Web App deployed to your Azure App Service.
3. Navigate to the URL of your Azure App Service to verify that the app is successfully deployed.

---

## Summary

In this lab, you have learned to:

- Create a GitHub Actions workflow to build and publish an ASP.NET web application.
- Define a deploy job that downloads the build artifact and deploys it to Azure.
- Push the workflow to GitHub and trigger it either automatically or manually.

In the next lab, you will add advanced deployment steps and explore reusable workflows for future use.

---

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Azure App Service Documentation](https://learn.microsoft.com/en-us/azure/app-service/)
