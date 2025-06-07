## Lab: React Tic-Tac-Toe CI / CD Workflow

## Introduction

In this lab, you will create a GitHub Actions workflow to build and dockerize a React Tic-Tac-Toe game. The workflow will initially focus on building and pushing a Docker image without caching. Later, caching will be introduced to demonstrate its optimization benefits.

> **Duration:** 45–60 minutes

---

## **Lab Objectives**

- Create a GitHub Actions workflow to build a React app.
- Build and push a Docker image to Docker Hub.
- Optimize the workflow by adding caching to speed up dependency installation.

---

## **Part 1: Building Without Caching**

### **Step 1: Initialize the Workflow**

1. Open your repository in **Visual Studio Code**.
2. Navigate to `.github/workflows/` and create a new file: `react-tic-tac-toe-build-dockerize.yml`.
3. Add the following workflow trigger configuration:

   ```yaml
   name: React Tic-Tac-Toe Build and Dockerize

   on:
     workflow_dispatch:
     push:
       paths:
         - '.github/workflows/react-tic-tac-toe-build-dockerize.yml'
         - 'src/react/react-tic-tac-toe/**'
   ```

---

### **Step 2: Configure Environment Variables**

Define environment variables for the Docker image and context path. These variables simplify workflow maintenance and ensure consistency.

```yaml
env:
  DOCKER_IMAGE: prasadhonrao/react-tic-tac-toe
  CONTEXT_PATH: ./src/react/react-tic-tac-toe
```

---

### **Step 3: Docker Hub Credentials**

Set up Docker Hub credentials as repository secrets:

1. Navigate to the repository's **Settings > Secrets and variables > Actions**.
2. Add the following secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.

---

### **Step 4: Define the Build Job**

1. Add a `build` job to:

   - Check out the code.
   - Set up Node.js.
   - Install dependencies and build the React app.

2. Insert this code into your workflow file:

   ```yaml
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout Code
           uses: actions/checkout@v4
           with:
             submodules: true

         - name: Set up Node.js
           uses: actions/setup-node@v4
           with:
             node-version: '20'

         - name: Install dependencies
           run: npm ci
           working-directory: ${{ env.CONTEXT_PATH }}

         - name: Build React App
           run: npm run build
           working-directory: ${{ env.CONTEXT_PATH }}
   ```

---

### **Step 5: Add the Dockerize Job**

1. Add a `dockerize` job to:

   - Build the Docker image.
   - Push it to Docker Hub.

2. Ensure the `dockerize` job depends on the `build` job to prevent running it prematurely.

   ```yaml
   dockerize:
     runs-on: ubuntu-latest
     needs: build
     steps:
       - name: Checkout Code
         uses: actions/checkout@v4

       - name: Set up Docker Buildx
         uses: docker/setup-buildx-action@v2

       - name: Log in to Docker Hub
         uses: docker/login-action@v2
         with:
           username: ${{ secrets.DOCKER_USERNAME }}
           password: ${{ secrets.DOCKER_PASSWORD }}

       - name: Build and Push Docker Image
         run: |
           cd ${{ env.CONTEXT_PATH }}
           TAG=${{ github.sha }}
           docker build -t ${{ env.DOCKER_IMAGE }}:$TAG -t ${{ env.DOCKER_IMAGE }}:latest .
           docker push ${{ env.DOCKER_IMAGE }}:$TAG
           docker push ${{ env.DOCKER_IMAGE }}:latest
   ```

---

### **Step 6: Test the Workflow**

1. Commit the file to your repository.
2. Push it to the `main` branch.
3. Navigate to the **Actions** tab, trigger the workflow manually, or observe it running on a push.
4. Check Docker Hub for the uploaded image.

---

## **Part 2: Adding Caching for Optimization**

To optimize the workflow, we'll cache the Node.js dependencies.

---

### **Step 1: Modify the Build Job**

1. Add a cache step before installing dependencies:

   ```yaml
   - name: Restore npm cache
     uses: actions/cache@v3
     with:
       path: ~/.npm
       key: ${{ runner.os }}-node-${{ hashFiles('${{ env.CONTEXT_PATH }}/package-lock.json') }}
       restore-keys: |
         ${{ runner.os }}-node-
   ```

2. Update the `build` job to include the caching step:

   ```yaml
   jobs:
     build:
       runs-on: ubuntu-latest
       steps:
         - name: Checkout Code
           uses: actions/checkout@v4
           with:
             submodules: true

         - name: Set up Node.js
           uses: actions/setup-node@v4
           with:
             node-version: '20'

         - name: Restore npm cache
           uses: actions/cache@v3
           with:
             path: ~/.npm
             key: ${{ runner.os }}-node-${{ hashFiles('${{ env.CONTEXT_PATH }}/package-lock.json') }}
             restore-keys: |
               ${{ runner.os }}-node-

         - name: Install dependencies
           run: npm ci
           working-directory: ${{ env.CONTEXT_PATH }}

         - name: Build React App
           run: npm run build
           working-directory: ${{ env.CONTEXT_PATH }}
   ```

---

### **Step 2: Test with Caching**

1. Commit the changes and push them to your repository.
2. Trigger the workflow again and observe:
   - Faster dependency installation if the cache is restored.

---

## **Complete Workflow File**

Here’s the final workflow file with caching:

```yaml
name: React Tic-Tac-Toe Build and Dockerize

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/react-tic-tac-toe-build-dockerize.yml'
      - 'src/react/react-tic-tac-toe/**'

env:
  DOCKER_IMAGE: prasadhonrao/react-tic-tac-toe
  CONTEXT_PATH: ./src/react/react-tic-tac-toe

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          submodules: true

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      - name: Restore npm cache
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('${{ env.CONTEXT_PATH }}/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      - name: Install dependencies
        run: npm ci
        working-directory: ${{ env.CONTEXT_PATH }}

      - name: Build React App
        run: npm run build
        working-directory: ${{ env.CONTEXT_PATH }}

  dockerize:
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and Push Docker Image
        run: |
          cd ${{ env.CONTEXT_PATH }}
          TAG=${{ github.sha }}
          docker build -t ${{ env.DOCKER_IMAGE }}:$TAG -t ${{ env.DOCKER_IMAGE }}:latest .
          docker push ${{ env.DOCKER_IMAGE }}:$TAG
          docker push ${{ env.DOCKER_IMAGE }}:latest
```

---

## **Summary**

- You created a GitHub Actions workflow to build and dockerize a React Tic-Tac-Toe game.
- First, you implemented the workflow without caching.
- Then, you optimized the workflow by adding a caching step, reducing build time.

---

### **Additional Resources**

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
