## Lab: Event - Pull Request

This lab will guide you through the process of creating a GitHub Actions workflow to handle pull request events, dynamically create environments, and simulate deployment tasks. By the end of this lab, you will have a functioning workflow that responds to pull requests on the `main` branch.

---

### **Objective**

1. Learn how to trigger workflows on pull request events.
2. Dynamically create environment names based on pull request numbers.
3. Simulate deployment tasks within a GitHub Actions workflow.

---

### **Prerequisites**

1. A GitHub repository.
2. Basic understanding of GitHub Actions.
3. Permissions to create workflows in the repository.

---

### **Steps**

#### **Step 1: Create a New Workflow**

1. Navigate to your repository on GitHub.
2. Go to the **Actions** tab.
3. Click on **New Workflow** or **Set up a workflow yourself**.
4. Name your workflow file `event-pull-request.yml` and place it under `.github/workflows/`.

---

#### **Step 2: Add the Workflow Configuration**

Copy the following YAML configuration into the workflow file:

```yaml
name: Pull Request Event

on:
  pull_request:
    branches:
      - main

jobs:
  create-environment:
    runs-on: ubuntu-latest
    steps:
      # Step 1: Checkout the repository
      - name: Checkout Code
        uses: actions/checkout@v3

      # Step 2: Set up dynamic environment name
      - name: Set Environment Name
        id: set-environment
        run: |
          # Generate a dynamic environment name based on PR number
          PR_NUMBER=${{ github.event.pull_request.number }}
          echo "environment-name=pr-${PR_NUMBER}" >> $GITHUB_ENV

      # Step 3: Deploy to the dynamically created environment
      - name: Deploy Application
        env:
          DEPLOY_ENV: ${{ env.environment-name }}
        run: |
          echo "Deploying application to environment: $DEPLOY_ENV"
          # Add your deployment commands here
```

---

#### **Step 3: Understand the Workflow**

- **Trigger**:  
  The workflow triggers on `pull_request` events targeting the `main` branch.

- **Steps**:
  1. **Checkout Code**: Pulls the repository's latest code for use in subsequent steps.
  2. **Dynamic Environment Name**:
     - Generates a unique environment name based on the pull request number (e.g., `pr-42`).
     - The environment name is stored in `GITHUB_ENV` for use in later steps.
  3. **Simulated Deployment**:
     - Simulates deploying the application to the dynamically created environment.
     - Outputs a log indicating the target environment.

---

#### **Step 4: Commit and Push**

1. Save the workflow file.
2. Commit the file to your repository:

   ```bash
   git add .github/workflows/pull-request-workflow.yml
   git commit -m "Add pull request workflow"
   git push origin main
   ```

---

#### **Step 5: Test the Workflow**

1. Open a new pull request to the `main` branch in your repository.
2. Navigate to the **Actions** tab and locate the workflow execution.
3. Verify that:
   - The workflow runs successfully.
   - A log appears showing the dynamic environment name (e.g., `pr-2`).
   - The simulated deployment task runs correctly.

---

#### **Step 6: Extend the Workflow (Optional)**

1. **Add a Cleanup Job**:  
   Include a job to delete the dynamic environment when the pull request is closed.

   ```yaml
   on:
     pull_request:
       types:
         - closed
   ```

2. **Integrate Real Deployment Steps**:  
   Replace the `echo` command in the deployment step with real deployment logic (e.g., deploy to a cloud environment).

---

### **Expected Output**

- When a pull request is created, the workflow dynamically generates an environment name and simulates deployment.
- The GitHub Actions interface shows logs confirming the environment name and the deployment simulation.

---

### **Troubleshooting**

- If the workflow doesn't trigger, ensure the pull request targets the `main` branch.
- Check syntax errors in the YAML file using a YAML linter.
- Verify that `Actions` are enabled for the repository.

---

### **Conclusion**

This lab demonstrates how to create a simple and dynamic GitHub Actions workflow to handle pull request events. You can extend this workflow to include additional steps, such as testing or actual deployment processes, based on your project needs.
