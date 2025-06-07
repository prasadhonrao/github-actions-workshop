## Lab: Publish ASP.NET Web API as a GitHub Package

## Introduction

In this lab, you will learn how to publish an **ASP.NET Core Web API** as a Docker image to the **GitHub Container Registry (GHCR)** using GitHub Actions. You will:

- Build an ASP.NET Core Web API project.
- Create a local Docker image.
- Push the Docker image as a package to GitHub Container Registry.

If you haven’t created the **ASP.NET Web API Project**, refer to the **[Create an ASP.NET Core Web API Project](./create-aspnet-webapi-lab.md)** lab instructions before proceeding.

> **Duration**: 30–40 minutes

---

## Prerequisites

1. **GitHub Token Authentication**:

   - The workflow uses the automatically provided **GitHub Token** (`secrets.GITHUB_TOKEN`) to authenticate with the GitHub Container Registry.

2. Ensure the **ASP.NET Web API Project** exists in the `./src/dotnet/Weather.WebApi` directory.

---

## Instructions

### Step 1: Create a GitHub Package Workflow

1. Navigate to your project directory and open the `.github/workflows` folder.
2. Create a new file named `aspnet-webapi-publish-github-package.yml`.
3. Copy the following workflow content into the file:

   ```yaml
   name: ASP.NET Web API Publish GitHub Package
   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/aspnet-webapi-publish-github-package.yml'
         - 'src/dotnet/Weather.WebApi/**'

   env:
     GITHUB_PACKAGE_NAME: ghcr.io/prasadhonrao/aspnet-weather-webapi

   jobs:
     build:
       runs-on: ubuntu-latest
       permissions:
         contents: read
         packages: write # Required for creating packages
       defaults:
         run:
           working-directory: ./src/dotnet/Weather.WebApi
       steps:
         - name: Checkout Code
           uses: actions/checkout@v4

         - name: Build ASP.NET Weather Web API
           run: dotnet build

         - name: Build Local Docker Image
           run: docker image build -t aspnet-weather-webapi .

         - name: Login to GitHub Container Registry
           uses: docker/login-action@v3
           with:
             registry: ghcr.io # GitHub Container Registry. Default is docker.io
             username: ${{ github.repository_owner }}
             password: ${{ secrets.GITHUB_TOKEN }}

         - name: Tag Image to latest
           run: docker tag aspnet-weather-webapi ${{ env.GITHUB_PACKAGE_NAME }}:latest

         - name: Tag Image to branch
           run: |
             BRANCH_NAME=${{ github.ref_name }}
             docker tag aspnet-weather-webapi ${{ env.GITHUB_PACKAGE_NAME }}:$BRANCH_NAME

         - name: Push Image with latest tag to GitHub Container Registry
           run: docker push ${{ env.GITHUB_PACKAGE_NAME }}:latest

         - name: Push Image with branch tag to GitHub Container Registry
           run: |
             BRANCH_NAME=${{ github.ref_name }}
             docker push ${{ env.GITHUB_PACKAGE_NAME }}:$BRANCH_NAME
   ```

4. Replace `prasadhonrao/aspnet-weather-webapi` with your own GitHub repository name in the `env` section.
5. Save the file.

---

### Step 2: Understanding the Workflow

1. **Event Triggers**:

   - The workflow triggers on two events:
     - A `push` event that modifies the workflow file or the project files.
     - A manual `workflow_dispatch` event for testing or deployment on demand.

2. **Environment Variables**:

   - The workflow defines an `env` variable named `GITHUB_PACKAGE_NAME`, which contains the name of the GitHub package.

3. **Steps in the Workflow**:

   - **Checkout Code**: Pulls the latest code from the repository.
   - **Build ASP.NET Web API**: Builds the Web API project using the .NET CLI.
   - **Build Local Docker Image**: Builds a Docker image using the `Dockerfile` in the project directory.
   - **Login to GitHub Container Registry**: Authenticates to the GitHub Container Registry using the built-in `GITHUB_TOKEN`.
   - **Tag Image**: Tags the built image with `latest` and the current branch name for versioning.
   - **Push Images to GitHub Container Registry**: Publishes the tagged images to the registry.

   These steps ensure that the Web API is built, containerized, and published as a GitHub package.

---

### Step 3: Trigger the Workflow

1. Commit and push the workflow file to your repository's `main` branch with a descriptive commit message, e.g., **"Add GitHub package publishing workflow"**.
2. Navigate to the **Actions** tab in your GitHub repository.
3. Locate the **ASP.NET Web API Publish GitHub Package** workflow and click **Run workflow** to trigger it manually.

---

### Step 4: Verify the Workflow Execution

1. Monitor the workflow logs:
   - Verify the **Build ASP.NET Weather Web API** step completes successfully.
   - Confirm that the Docker image is built locally.
   - Ensure the images are tagged with both `latest` and the branch name.
   - Confirm that the images are pushed to the GitHub Container Registry.
2. Navigate to the **Packages** section in your GitHub repository and verify that the container image appears.

---

### Step 5: Pull and Test the GitHub Package Locally

1. On your local machine, authenticate with GitHub Container Registry:

   ```bash
   echo $GITHUB_TOKEN | docker login ghcr.io -u <your_github_username> --password-stdin
   ```

2. Pull the image from GitHub Container Registry:

   ```bash
   docker pull ghcr.io/prasadhonrao/aspnet-weather-webapi:latest
   ```

   Replace `prasadhonrao/aspnet-weather-webapi` with your repository's package name.

3. Run the Docker container:

   ```bash
   docker run -d -p 8080:80 ghcr.io/prasadhonrao/aspnet-weather-webapi:latest
   ```

4. Access the running application in your browser at `http://localhost:8080` and test the Web API endpoints.

---

## Summary

In this lab, you:

- Built and containerized an ASP.NET Web API project.
- Used GitHub Actions to publish the Docker image to GitHub Container Registry as a package.
- Verified the package and tested it locally.

You can now distribute your ASP.NET Web API as a Docker container directly through GitHub Packages.

---

## Additional Resources

- [GitHub Container Registry Documentation](https://docs.github.com/en/packages/working-with-a-github-container-registry)
- [GitHub Actions: Docker Login](https://github.com/marketplace/actions/docker-login)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
