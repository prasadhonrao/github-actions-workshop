## Lab: NGINX Deployment on AKS Using ARC Runner

### **Introduction**

In this lab, you will learn how to deploy a Docker container (NGINX) to an Azure Kubernetes Service (AKS) cluster using GitHub Actions with the Actions Runner Controller (ARC). The workflow will automatically run on an `arc-runner-set` self-hosted runner deployed in AKS.

> **Duration**: 20-30 minutes

---

### **Prerequisites**

Before starting this lab, ensure you have:

- An AKS cluster up and running.
- An Azure Service Principal created and added as GitHub secrets.
- ARC setup in your AKS cluster (self-hosted runners).
- GitHub repository with appropriate access and permissions.

---

## Instructions

### **Step 1: Create a GitHub Actions Workflow File**

1. In your GitHub repository, navigate to the `.github/workflows` directory. If the folder does not exist, create it.
2. Create a new file named `k8s-arc-runner-nginx.yml` and add the following content:

```yaml
name: K8s ARC Runner NGINX

on:
  push:
    paths:
      - '.github/workflows/k8s-arc-runner-nginx.yml'
  workflow_dispatch:

jobs:
  run:
    runs-on: arc-runner-set
    steps:
      # Step 1: Checkout the code to get any necessary configuration files
      - name: Checkout code
        uses: actions/checkout@v4.1.7

      # Step 2: Set up kubectl
      - name: Set up kubectl
        uses: azure/setup-kubectl@v3
        with:
          kubectl-version: 'v1.25.0'

      # Step 3: Configure kubectl to connect to AKS
      - name: Configure kubectl
        uses: azure/aks-set-context@v1
        with:
          resource-group: 'arc-lab-rg'
          cluster-name: 'arc-lab-cluster'
          creds: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}

      # Step 4: Deploy an existing Docker image (e.g., nginx) to AKS
      - name: Deploy NGINX to AKS
        run: |
          kubectl create deployment nginx-deployment --image=nginx:latest
          kubectl expose deployment nginx-deployment --port=80 --target-port=80 --type=LoadBalancer
          kubectl rollout status deployment/nginx-deployment

      # Step 5: Verify that the deployment was successful by checking the pods and service
      - name: Verify Deployment
        run: |
          kubectl get pods
          kubectl get services
          kubectl describe deployment nginx-deployment

      # Optional: Clean up the deployment after the demo
      # - name: Clean up deployment
      #   run: |
      #     kubectl delete deployment nginx-deployment
      #     kubectl delete service nginx-deployment
```

3. Commit and push the workflow file to your GitHub repository.

---

### **Step 2: Set Up the Azure Service Principal in GitHub Secrets**

1. Go to **GitHub Repository Settings** > **Secrets** > **Actions**.
2. Add the following secrets with values from your Azure Service Principal credentials:
   - `AZURE_SERVICE_PRINCIPAL`: The JSON output from the Azure CLI command you ran to create the Service Principal (or manually add these fields as separate secrets).

---

### **Step 3: Configure kubectl to Access AKS**

1. The **`azure/aks-set-context@v1`** action will automatically configure `kubectl` using the Azure Service Principal credentials and your AKS details.

2. Ensure you have provided the correct `resource-group` and `cluster-name` values in the workflow file, replacing `aks-rg` and `aks` with your actual Azure resource group and AKS cluster name.

---

### **Step 4: Deploy NGINX to AKS**

1. In the workflow, the **`kubectl create deployment`** command is used to create an NGINX deployment in the AKS cluster using the latest NGINX Docker image.
2. The **`kubectl expose deployment`** command is used to expose the NGINX deployment on port 80 as a **LoadBalancer** service.
3. The **`kubectl rollout status`** command waits for the deployment to be successfully rolled out.

---

### **Step 5: Verify the Deployment**

1. After the deployment, the workflow will run the following commands to verify the NGINX deployment:

   - **`kubectl get pods`**: To list all pods and their status.
   - **`kubectl get services`**: To check if the LoadBalancer service has been created successfully.
   - **`kubectl describe deployment nginx-deployment`**: To get detailed information about the deployment.

2. These commands will allow you to monitor the status of the NGINX deployment.

---

### **Step 6: Optional - Clean Up the Deployment**

1. After the demo, you can remove the NGINX deployment and associated service using the following commands in the workflow:

   ```yaml
   - name: Clean up deployment
     run: |
       kubectl delete deployment nginx-deployment
       kubectl delete service nginx-deployment
   ```

2. This step is commented out by default, but you can uncomment it if you want to clean up the resources after the demo.

---

### **Step 7: Monitor Workflow and Deployment**

1. Once the workflow is committed and pushed to GitHub, navigate to the **Actions** tab in your GitHub repository.
2. You will see the new workflow triggered by your push.
3. Click on the workflow to view the logs and confirm the steps are executing correctly.
4. You can monitor the deployment in the Azure portal, under **Kubernetes Services** to see the LoadBalancer and deployed NGINX instance.

---

## **Summary**

In this lab, you deployed an NGINX container to an Azure Kubernetes Service (AKS) cluster using GitHub Actions with the Actions Runner Controller (ARC). You:

- Created a workflow that runs on an ARC self-hosted runner.
- Configured `kubectl` to interact with AKS using an Azure Service Principal.
- Deployed NGINX to AKS and exposed it via a LoadBalancer service.
- Verified the deployment by checking the status of the pods and services.

You also learned how to monitor and clean up the deployed resources in AKS.
