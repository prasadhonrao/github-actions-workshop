## Lab: Creating a Shared Workflow for Deploying an ASP.NET Web App to Azure

## Objective

In this lab, you will learn how to create a shared GitHub Actions workflow for deploying an ASP.NET Web App to Azure. This reusable workflow will allow you to standardize the deployment process across multiple workflows or projects by passing in parameters for the web app name and package path.

### Prerequisites

1. **GitHub Repository**: A GitHub repository to store the workflow YAML files and use GitHub Actions.

---

### Step 1: Create Shared Workflow Repository

1. **Create a New Repository**:
   - Go to [GitHub](http://github.com) and log in.
2. **Create a New Repository**:
   - Click on the **New** button to create a new repository.
   - Enter a name for the repository (e.g., `github-actions-workshop-shared-workflows`).
   - Add a description (e.g., `Shared GitHub Actions workflows`).
   - Choose the repository visibility (e.g., public or private).
   - Click on the **Create repository** button.

### Step 2: Create the Shared Workflow File

1. Navigate to the `.github/workflows` directory of your repository.
2. Create a new file named `deploy.yml`.
3. Define the shared workflow:
   Paste the following YAML content into the `deploy.yml` file. This workflow is responsible for deploying the web app to Azure.

```yaml
name: Shared Workflow Azure Web App Deploy

on:
  workflow_call:
    inputs:
      AZURE_WEBAPP_PACKAGE_PATH:
        required: true
        type: string
      AZURE_WEBAPP_NAME:
        required: true
        type: string
    secrets:
      AZURE_SERVICE_PRINCIPAL:
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Download artifact from build job
        uses: actions/download-artifact@v4
        with:
          name: webapp
          path: ${{ inputs.AZURE_WEBAPP_PACKAGE_PATH }}
      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}
      - name: Deploy to Azure WebApp
        uses: azure/webapps-deploy@v2
        with:
          app-name: ${{ inputs.AZURE_WEBAPP_NAME }}
          package: ${{ inputs.AZURE_WEBAPP_PACKAGE_PATH }}
```

#### Breakdown of the workflow

- **`workflow_call`**: This event allows other workflows to call this shared workflow. It defines two required inputs:

  - `AZURE_WEBAPP_PACKAGE_PATH`: The path to the web app package that will be deployed.
  - `AZURE_WEBAPP_NAME`: The name of the Azure Web App where the package will be deployed.

  It also defines a required secret `AZURE_SERVICE_PRINCIPAL` for authentication with Azure.

- **`deploy` job**:
  - **`actions/download-artifact@v4`**: Downloads the build artifact (the web app package) from the previous job or workflow.
  - **`azure/login@v2`**: Logs in to Azure using the provided service principal credentials.
  - **`azure/webapps-deploy@v2`**: Deploys the web app package to the specified Azure Web App.

---

## Summary

Congratulations! You have created a shared GitHub Actions workflow for deploying an ASP.NET Web App to Azure. This shared workflow can be reused across multiple workflows or projects by passing in parameters for the web app name and package path.
