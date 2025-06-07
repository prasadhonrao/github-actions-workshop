## Lab: Deploy ASP.NET Web App to Azure Using Shared Workflow

## Introduction

In this lab, you will use a shared GitHub Actions workflow to deploy an ASP.NET Web App to Azure.

## Prerequisites

1. **GitHub Repository**: A GitHub repository to store the workflow YAML files and use GitHub Actions.
2. You should have shared workflow created as instructed in the [Creating a Shared Workflow Lab](./create-shared-workflow-lab.md).
3. **Azure Subscription and Service Principal**: You need an Azure subscription and a service principal to authenticate with Azure. The service principal should be stored as a GitHub secret.

---

### Step 1: Set Up the Main Workflow File

1. **Navigate to the `.github/workflows` directory** in your GitHub repository.
2. **Create a new workflow YAML file** for your main deployment pipeline. Name the file `aspnet-webapp-deploy-to-azure-using-shared-workflow.yml` (or any preferred name).

3. The starter code for the main workflow is provided in [Starter Template](./deploy-to-azure-shared-workflow-starter.md). Copy the code and paste it into the newly created workflow file.

4. Now we will modify the workflow to use the shared workflow for deploying the ASP.NET Web App to Azure. Update the workflow file with the following code, put that under 'deploy' job:

```yaml
needs: build
uses: prasadhonrao/github-actions-workshop-shared-repo/.github/workflows/deploy.yml@main
with:
  AZURE_WEBAPP_PACKAGE_PATH: webapp
  AZURE_WEBAPP_NAME: ${{ env.AZURE_WEBAPP_NAME }}
secrets:
  AZURE_SERVICE_PRINCIPAL: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}
```

#### Explanation

- The `needs: build` keyword ensures that the deployment job runs only after the build job is successful.
- The `prasadhonrao/github-actions-workshop-shared-repo/.github/workflows/deploy.yml@main` syntax references the shared workflow file for deploying the ASP.NET Web App to Azure.
- The `with` keyword passes the required parameters to the shared workflow:
  - `AZURE_WEBAPP_PACKAGE_PATH`: The path to the published web app package.
  - `AZURE_WEBAPP_NAME`: The name of the Azure Web App to deploy.
- The `secrets` section provides the Azure Service Principal secret to authenticate the deployment workflow with Azure.

---

### Step 2: Configure Secrets in GitHub Repository

For the deployment process to authenticate with Azure, you need to add the Azure Service Principal as a secret in your GitHub repository.

1. **Create an Azure Service Principal**:
   - Follow the [official guide](https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1?tabs=bash) to create a Service Principal in Azure. You will need the following details:
     - **App ID** (Client ID)
     - **Tenant ID**
     - **Client Secret**
2. **Add the Service Principal to GitHub Secrets**:
   - Go to your repository in GitHub.
   - Navigate to **Settings** > **Secrets and variables** > **Actions**.
   - Click **New repository secret** and name it `AZURE_SERVICE_PRINCIPAL`.
   - Paste the Service Principal information in the following format:
     ```json
     {
       "clientId": "<App-ID>",
       "clientSecret": "<Secret>",
       "tenantId": "<Tenant-ID>"
     }
     ```

---

### Step 3: Triggering the Workflow

Once the workflow is set up, you can trigger the deployment in two ways:

1. **Push to GitHub**:

   - The workflow will automatically run whenever changes are pushed to the `src/dotnet/WebApp/**` path or the workflow files (`.github/workflows/aspnet-webapp-deploy.yml`).

2. **Manually Trigger the Workflow**:
   - You can also trigger the workflow manually by going to the **Actions** tab in GitHub and selecting the **ASP.NET Web App Deploy to Azure** workflow. Click **Run Workflow** and select the branch to run the workflow.

---

### Step 4: Monitor the Workflow Execution

1. **Go to the Actions tab in your GitHub repository**.
2. **Monitor the workflow execution**:
   - You should see the workflow running, with logs from the `build` and `deploy` jobs.
   - If everything is set up correctly, your ASP.NET Web App will be built, published, and deployed to Azure.

---

### Step 5: Conclusion

In this lab, you successfully created a GitHub Actions workflow that builds an ASP.NET Web App, then deploys it to Azure using a shared workflow. By breaking the deployment logic into a shared workflow, you can easily reuse it across multiple projects, streamlining your CI/CD pipeline.

### Next Steps

- Explore integrating other Azure-related workflows or testing workflows in your pipeline.
- Customize the shared deployment workflow to handle different environments (e.g., staging, production).

---

This concludes the lab on deploying an ASP.NET Web App to Azure using a shared workflow.
