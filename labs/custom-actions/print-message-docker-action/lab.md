## Lab: Create a Custom Docker GitHub Action

### **Objective:**

In this lab, you will create a custom GitHub Action using Docker. The action will use a Docker container to execute a simple task, such as printing a message.

---

### **Prerequisites:**

- An existing GitHub repository (either personal or part of an organization).
- Basic understanding of GitHub Actions and Docker.
- Docker installed locally (optional, for testing before using on GitHub).

---

### **Step 1: Set Up Your Docker GitHub Action Directory**

1. Navigate to your **existing GitHub repository** where you want to create the custom Docker action.
2. Create the following directory structure:

   ```bash
   mkdir -p .github/actions/hello-docker
   cd .github/actions/hello-docker
   ```

3. Inside the `.github/actions/hello-docker` directory, create the following files:
   - `Dockerfile`
   - `entrypoint.sh`
   - `action.yml`

---

### **Step 2: Create the Dockerfile**

The `Dockerfile` will define the Docker image for your custom action.

Create the file `.github/actions/hello-docker/Dockerfile` with the following content:

```Dockerfile
# Use an official Node.js runtime as a parent image
FROM node:16

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the entrypoint script to the container
COPY entrypoint.sh /usr/src/app/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x entrypoint.sh

# Set the default command to run the entrypoint script
ENTRYPOINT ["./entrypoint.sh"]
```

This `Dockerfile`:

- Starts from the official Node.js 16 image.
- Sets the working directory to `/usr/src/app`.
- Copies the `entrypoint.sh` script into the container.
- Makes the script executable and sets it as the container's entry point.

---

### **Step 3: Create the Entry Point Script (`entrypoint.sh`)**

The `entrypoint.sh` script will be executed when the Docker container runs. This script can do anything you like. For simplicity, it will just print a message.

Create the file `.github/actions/hello-docker/entrypoint.sh` with the following content:

```bash
#!/bin/bash

# Print a message passed via the action input or a default message
echo "Hello from the Docker Action! Here is your input: $1"
```

This script:

- Prints a message to the GitHub Actions log. It uses the input argument passed to the action (we will define this input in the `action.yml`).

---

### **Step 4: Create the Action Metadata (`action.yml`)**

The `action.yml` file defines the metadata for the GitHub Action, including its inputs, description, and how it runs.

Create the file `.github/actions/hello-docker/action.yml` with the following content:

```yaml
name: 'Hello Docker Action'
description: 'A simple Docker action that prints a message.'

inputs:
  message:
    description: 'The message to print.'
    required: true
    default: 'Hello, World!'

runs:
  using: 'docker'
  image: 'Dockerfile'
```

This `action.yml`:

- Defines an input `message` (a string), which is required and has a default value of `'Hello, World!'`.
- Specifies that the action runs in a Docker container, using the `Dockerfile` you created.

---

### **Step 5: Build and Test the Action Locally (Optional)**

Before pushing the action to GitHub, you can build and test it locally using Docker (optional step).

1. Build the Docker image:

   ```bash
   docker build -t hello-docker-action .
   ```

2. Run the Docker container, passing in an input value:
   ```bash
   docker run hello-docker-action "This is a custom message!"
   ```

You should see the output:

```
Hello from the Docker Action! Here is your input: This is a custom message!
```

---

### **Step 6: Commit the Action Files**

Once you've created the Docker action, commit the files to your repository:

```bash
git add .github/actions/hello-docker/*
git commit -m "Create Hello Docker action"
git push origin main
```

---

### **Step 7: Create a Workflow to Use the Action**

Now that you have created the custom Docker action, you need to create a workflow that will use this action.

1. In the root of your repository, create the `.github/workflows` directory if it doesn't already exist.
2. Create a new file called `docker-action.yml` in `.github/workflows` with the following content:

```yaml
name: Run Hello Docker Action

on:
  push:
    paths:
      - '.github/actions/hello-docker/**'
  workflow_dispatch:

jobs:
  hello-docker:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Run Hello Docker Action
        uses: ./.github/actions/hello-docker
        with:
          message: 'This is a custom message from the workflow!'
```

This workflow:

- Runs whenever there is a push to the action's directory or when manually triggered.
- Uses your custom Docker action to print the `message` input you defined in `action.yml`.

---

### **Step 8: Run the Workflow**

1. Push the workflow to your repository:

   ```bash
   git add .github/workflows/docker-action.yml
   git commit -m "Add workflow to run Hello Docker action"
   git push origin main
   ```

2. Go to the **Actions** tab in your GitHub repository to see the workflow run.

3. Check the output of the "Run Hello Docker Action" step. You should see the custom message printed in the logs.

---

### **Conclusion:**

In this lab, you have:

- Created a custom Docker GitHub Action.
- Defined inputs and the Docker environment for the action.
- Created a workflow to trigger and use the custom action.

You can now expand on this basic example to build more complex Docker-based GitHub Actions. For example, you could create an action that runs tests inside a Docker container or deploys an app using Docker.
