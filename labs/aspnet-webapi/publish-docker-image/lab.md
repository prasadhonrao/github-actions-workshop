## Lab: Publish ASP.NET Web API as a Docker Image

## Introduction

In this lab, you will learn how to publish an **ASP.NET Core Web API** as a Docker image using GitHub Actions. You will:

- Build an ASP.NET Core Web API project.
- Create a local Docker image.
- Push the Docker image to Docker Hub.

If you haven’t created the **ASP.NET Web API Project**, refer to the **[Create an ASP.NET Core Web API Project](./create-aspnet-webapi-lab.md)** lab instructions before proceeding.

> **Duration**: 30–40 minutes

---

## Prerequisites

1. **Docker Hub Account**:

   - Create an account at [Docker Hub](https://hub.docker.com) if you don't already have one.

2. **GitHub Repository Secrets**:

   - Add two secrets to your GitHub repository:
     - `DOCKER_USERNAME`: Your Docker Hub username.
     - `DOCKER_PASSWORD`: Your Docker Hub PAT.

3. Ensure the **ASP.NET Web API Project** exists in the `./src/dotnet/Weather.WebApi` directory.

---

## Instructions

### Step 1: Create a Docker Workflow

1. Navigate to your GitHub repository directory and open the `.github/workflows` folder.
2. Create a new file named `aspnet-webapi-publish-docker-image.yml`.
3. Copy the following workflow content into the file:

   ```yaml
   name: ASP.NET Web API Publish Docker Image
   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/aspnet-webapi-publish-docker-image.yml'
         - 'src/dotnet/Weather.WebApi/**'

   env:
     DOCKER_IMAGE: prasadhonrao/aspnet-weather-webapi

   jobs:
     build:
       runs-on: ubuntu-latest
       defaults:
         run:
           working-directory: ./src/dotnet/Weather.WebApi
       permissions:
         contents: read
       steps:
         - name: Checkout Code
           uses: actions/checkout@v4

         - name: Build ASP.NET Weather Web API
           run: dotnet build

         - name: Build Local Docker Image
           run: docker image build -t aspnet-weather-webapi .

         - name: List Docker Images
           run: docker image ls

         - name: Log in to Docker Hub
           uses: docker/login-action@v2
           with:
             username: ${{ secrets.DOCKER_USERNAME }}
             password: ${{ secrets.DOCKER_PASSWORD }}

         - name: Tag Image to latest
           run: docker tag aspnet-weather-webapi ${{ env.DOCKER_IMAGE }}:latest

         - name: Push Image with latest tag to Docker Hub Registry
           run: docker push ${{ env.DOCKER_IMAGE }}:latest

         - name: List Docker Images
           run: docker image ls
   ```

4. Replace `prasadhonrao/aspnet-weather-webapi` with your own Docker Hub repository name in the `env` section.
5. Save the file.

---

### Step 2: Understanding the Workflow

1. **Event Triggers**:

   - The workflow triggers on two events:
     - A `push` event that modifies the workflow file or the project files.
     - A manual `workflow_dispatch` event for testing or deployment on demand.

2. **Environment Variables**:

   - The workflow defines an `env` variable named `DOCKER_IMAGE`, which contains the name of the Docker image to be built and pushed.

3. **Steps in the Workflow**:

   - **Checkout Code**: Pulls the latest code from the repository.
   - **Build ASP.NET Web API**: Builds the Web API project using the .NET CLI.
   - **Build Local Docker Image**: Builds a Docker image using the `Dockerfile` in the project directory.
   - **List Docker Images**: Lists all local Docker images for verification.
   - **Log in to Docker Hub**: Authenticates to Docker Hub using the secrets provided.
   - **Tag Image**: Tags the built image with `latest` for versioning.
   - **Push Image to Docker Hub**: Publishes the tagged image to your Docker Hub repository.

   These steps together ensure that the Web API is built, containerized, and published for use.

---

### Step 3: Trigger the Workflow

1. Commit and push the workflow file to your repository's `main` branch with a descriptive commit message, e.g., **"Add Docker image publishing workflow"**.
2. Navigate to the **Actions** tab in your GitHub repository.
3. Locate the **ASP.NET Web API Publish Docker Image** workflow and click **Run workflow** to trigger it manually.

---

### Step 4: Verify the Workflow Execution

1. Monitor the workflow logs:
   - Verify the **Build ASP.NET Weather Web API** step completes successfully.
   - Confirm that the Docker image is built locally.
   - Ensure the image is tagged with `latest` and pushed to Docker Hub.
2. After the workflow completes, log in to your Docker Hub account and verify that the image is listed in your repository.

---

### Step 5: Pull and Test the Docker Image Locally

1. On your local machine, pull the image from Docker Hub:

   ```bash
   docker pull prasadhonrao/aspnet-weather-webapi:latest
   ```

   Replace `prasadhonrao/aspnet-weather-webapi` with your own Docker Hub repository name.

2. Run the Docker container:

   ```bash
   docker run -d -p 8080:80 prasadhonrao/aspnet-weather-webapi:latest
   ```

3. Access the running application in your browser at `http://localhost:8080` and test the Web API endpoints.

---

## Summary

In this lab, you:

- Built and containerized an ASP.NET Web API project.
- Used GitHub Actions to automate the publishing of a Docker image.
- Pushed the Docker image to Docker Hub for distribution.

You can now deploy your ASP.NET Web API as a containerized application anywhere Docker is supported.

---

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [GitHub Actions: Docker Login](https://github.com/marketplace/actions/docker-login)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
