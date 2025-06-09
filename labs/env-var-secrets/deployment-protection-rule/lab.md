## Lab : Deployment Protection Rules

This lab will guide you through configuring **Required Reviewers** as a deployment protection rule for a specific environment (e.g., `prod`) in GitHub. You'll also learn how to create a workflow to demonstrate this protection rule in action.

---

### **Objective**

1. Understand how to configure deployment protection rules in GitHub environments.
2. Set up a GitHub Actions workflow that triggers deployment to environments with and without protection rules.
3. Observe and understand how required reviewers affect the workflow execution.

---

### **Prerequisites**

1. A GitHub repository.
2. Two pre-created environments: **`dev`** and **`prod`**.
3. Admin access to the repository to configure environment settings.
4. A GitHub Actions workflow file to deploy to the environments.

---

### **Steps**

#### **Step 1: Create and Configure Environments**

1. Navigate to your GitHub repository.
2. Go to **Settings** > **Environments**.
3. Create two environments:
   - **dev**
   - **prod**
4. Click on the **prod** environment and configure the following:
   - **Protection Rules**:
     - Enable **"Required reviewers"**.
     - Add specific reviewers (e.g., yourself or other team members).
   - **Deployment Branches**:
     - Optionally restrict deployments to specific branches (e.g., `main`).

---

#### **Step 2: Create the Workflow**

Set up a workflow to deploy to both `dev` and `prod` environments. The workflow includes steps for deploying to both environments, highlighting the approval required for `prod`.

Create a workflow file under `.github/workflows/env-deployment-protection-rule.yml`:

```yaml
name: Deployment Workflow

on:
  push:
    branches:
      - main

jobs:
  deploy-to-dev:
    runs-on: ubuntu-latest
    environment: dev
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Deploy to Dev
        run: echo "Deploying to the dev environment."

  deploy-to-prod:
    needs: deploy-to-dev
    runs-on: ubuntu-latest
    environment: prod
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Deploy to Prod
        run: echo "Deploying to the prod environment."
```

---

#### **Step 3: Understand the Workflow**

1. **Trigger**:

   - The workflow is triggered on a `push` to the `main` branch.

2. **Jobs**:

   - `deploy-to-dev`:
     - Deploys to the `dev` environment without requiring approval.
   - `deploy-to-prod`:
     - Deploys to the `prod` environment, but requires approval due to the protection rule.

3. **Approval Process**:
   - When the workflow reaches the `deploy-to-prod` step, it pauses and requires the assigned reviewers to approve the deployment before proceeding.

---

#### **Step 4: Commit and Push the Workflow**

1. Save the workflow file.
2. Commit and push it to the `main` branch:

   ```bash
   git add .github/workflows/env-deployment-protection-rule.yml
   git commit -m "Add deployment workflow with protection rule"
   git push origin main
   ```

---

#### **Step 5: Trigger the Workflow**

1. Push changes to the `main` branch or manually trigger the workflow from the **Actions** tab.
2. Observe the workflow execution:
   - The `deploy-to-dev` job completes without interruptions.
   - The `deploy-to-prod` job pauses and waits for approval.

---

#### **Step 6: Approve the Deployment**

1. Navigate to the **Actions** tab in your repository.
2. Select the running workflow.
3. Click **Review deployments** under the paused `deploy-to-prod` step.
4. Approve the deployment as a required reviewer.

---

#### **Expected Outcome**

1. The workflow successfully deploys to `dev` without interruption.
2. The workflow pauses at `prod` until required reviewers approve the deployment.
3. Once approved, the deployment to `prod` resumes and completes.

---

### **Key Discussion Points**

1. **Why Use Protection Rules?**

   - Ensures critical environments like `prod` are accessed and modified only with proper oversight.
   - Helps enforce change management processes.

2. **Difference Between `dev` and `prod` in This Lab**:

   - `dev` allows direct deployment without approval.
   - `prod` requires approval to simulate a real-world production environment.

3. **Scenarios for Using Required Reviewers**:
   - Critical production releases.
   - Compliance or security-sensitive environments.
   - Multi-stakeholder sign-offs.

---

### **Lab Extensions**

1. **Simulate a Failed Approval**:

   - Reject the approval and observe how the workflow fails to proceed.

2. **Add Conditional Deployment**:

   - Use `if` conditions to skip deployment to `prod` based on certain criteria, such as branch name or pull request labels.

3. **Expand to Multi-Environment Workflow**:
   - Add more environments (e.g., `staging`, `qa`) with varying levels of protection.

---

### **Conclusion**

This lab demonstrates how to configure and use deployment protection rules in GitHub environments, specifically using required reviewers for production deployments. This setup is critical for maintaining oversight and quality control in CI/CD pipelines, especially when managing sensitive or high-risk deployments.
