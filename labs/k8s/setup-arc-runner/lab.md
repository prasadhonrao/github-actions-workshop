## Lab: Setup ARC Runner

## Introduction

In this lab, you will set up the **Azure Kubernetes Service (AKS)** cluster and install the required tools to deploy GitHub Actions Runner Controller (ARC). You will also set up the necessary environment for GitHub Actions to run workflows using the self-hosted runner.

> **Duration**: 90-120 minutes

---

## Prerequisites

Before starting this lab, ensure that you have:

- A **GitHub account** with access to a repository.
- An **Azure account** to create an AKS cluster.
- Basic knowledge of **Kubernetes** and **Helm**.
- The following **CLI tools** installed on your local machine:
  - **Azure CLI**
  - **kubectl**
  - **Helm**

You can follow the documentation to install the required CLI tools:

- [Azure CLI Installation](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl Installation](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Helm Installation](https://helm.sh/docs/intro/install/)

---

## Instructions

### Step 1: Set Up the AKS Cluster and Install Prerequisite Tools

In this step, you will set up the AKS cluster and install the required CLI tools.

---

#### 1.1 Install Required CLI Tools

Make sure the following tools are installed:

1. **Azure CLI**

   - Download and install Azure CLI from the [official website](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli).
   - Verify the installation:

     ```bash
     az version
     ```

2. **kubectl**

   - Install `kubectl` using the Azure CLI:

     ```bash
     az aks install-cli
     ```

   - Verify the installation:

     ```bash
     kubectl version --client
     ```

3. **Helm**

   - Download Helm from the [Helm website](https://helm.sh/docs/intro/install/).
   - Verify the installation:

     ```bash
     helm version
     ```

---

#### 1.2 Create the AKS Cluster

1. **Log in to Azure CLI**:

   ```bash
   az login
   ```

   This will open a browser window to authenticate your account.

2. **Create a Resource Group**:

   ```bash
   az group create --name arc-lab-rg --location uksouth
   ```

3. **Create the AKS Cluster**:
   Create an AKS cluster with 2 nodes and SSH keys:

   ```bash
   az aks create \
       --resource-group arc-lab-rg \
       --name arc-lab-cluster \
       --node-count 2 \
       --generate-ssh-keys
   ```

4. **Get the AKS Credentials**:
   Fetch the credentials to interact with the AKS cluster using `kubectl`:

   ```bash
   az aks get-credentials --resource-group arc-lab-rg --name arc-lab-cluster
   ```

5. **Verify the Cluster**:
   Ensure your cluster is accessible:

   ```bash
   kubectl get nodes
   ```

   You should see a list of the nodes in your AKS cluster.

---

#### 1.3 Set Up Namespace and Prepare for ARC Installation

1. **Create a Namespace for ARC**:
   Create a dedicated namespace for Actions Runner Controller:

   ```bash
   kubectl create namespace arc-runners
   ```

2. **Optional**: If you later decide to set up custom **cert-manager** (for TLS certificates), follow the instructions below. This step is optional for now and can be skipped for most users.

---

#### **Step 1 Completion**

At this stage, you should have:

1. All required CLI tools installed (`Azure CLI`, `kubectl`, `Helm`).
2. An AKS cluster successfully created and verified.
3. The `arc-runners` namespace created for deploying ARC.

You’re now ready to move on to the next step of deploying the **Actions Runner Controller (ARC)**.

---

### Step 2: Install and Configure the GitHub Actions Runner Controller (ARC)

In this step, we will install the **GitHub Actions Runner Controller (ARC)** into your AKS cluster using Helm. The ARC will manage self-hosted runners that can be used by your GitHub workflows.

1. **Install the Actions Runner Controller:**

   First, install the **Actions Runner Controller** in the `arc-systems` namespace by running the following Helm command:

   ```bash
   NAMESPACE="arc-systems"
   helm install arc \
       --namespace "${NAMESPACE}" \
       --create-namespace \
       oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller
   ```

   - The `helm install` command will install the **Actions Runner Controller** into your AKS cluster.
   - It uses the Helm chart from GitHub Container Registry to manage self-hosted runners as Kubernetes resources.

2. **Configure the GitHub Runner:**

   After the installation, you need to configure the runner set with your GitHub repository. You will set the repository URL and the GitHub Personal Access Token (PAT) that the ARC will use to authenticate with your GitHub account.

   Run the following command to configure the ARC:

   ```bash
   INSTALLATION_NAME="arc-runner-set"
   NAMESPACE="arc-runners"
   GITHUB_CONFIG_URL="https://github.com/prasadhonrao/github-actions-workshop"
   GITHUB_PAT="your_personal_access_token_here"
   helm upgrade "${INSTALLATION_NAME}" \
       --namespace "${NAMESPACE}" \
       --create-namespace \
       --set githubConfigUrl="${GITHUB_CONFIG_URL}" \
       --set githubConfigSecret.github_token="${GITHUB_PAT}" \
       oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set
   ```

   - `githubConfigUrl`: This is the URL to your GitHub repository where you want to set up the runner.
   - `githubConfigSecret.github_token`: This is the **Personal Access Token (PAT)** that will authenticate the ARC with GitHub and give it the necessary permissions to manage self-hosted runners for your repository.

3. **Create the GitHub Token Secret:**

   If you haven’t already created a Kubernetes secret for your GitHub PAT, do so by running:

   ```bash
   kubectl create secret generic github-token \
      --namespace=arc-runners \
      --from-literal=github_token='your_personal_access_token_here'
   ```

   - This command creates a secret in the `arc-runners` namespace, storing the GitHub token which is used by the Actions Runner Controller for authentication.

---

### Step 3: Monitor the Actions Runner Controller

After installing and configuring the GitHub Actions Runner Controller (ARC), you can monitor the status of the runners and verify that the controller is managing them properly. This step ensures that the ARC is correctly creating and scaling runner containers based on your GitHub workflows.

1. **Check the Status of the Pods:**

   To verify that the **Actions Runner Controller** is running correctly, use the following command to check the status of the pods in the `arc-runners` namespace:

   ```bash
   kubectl get pods -n arc-runners
   ```

   - This will list all the pods running in the `arc-runners` namespace, which includes the controller's pods and the self-hosted runner pods.
   - If the setup is successful, you should see pods with names like `arc-runner-set-*` indicating the runner set.

2. **Check the Logs of the Actions Runner Controller:**

   To get more detailed information about the actions and potential issues with the runner controller, check the logs of the ARC pod. First, identify the pod name:

   ```bash
   kubectl get pods -n arc-systems
   ```

   Then, fetch the logs for the pod with the following command:

   ```bash
   kubectl logs -n arc-systems <arc-controller-pod-name>
   ```

   - This will show you the logs of the Actions Runner Controller, helping you monitor for any errors or issues in the runner setup process.

3. **Monitor the Runner Pod Creation:**

   Once your GitHub workflow triggers the runner to start, the ARC should dynamically create a runner pod. To monitor this, watch the pod creation events in the `arc-runners` namespace:

   ```bash
   kubectl get pods -n arc-runners --watch
   ```

   - This will display real-time events of pod creations and deletions as workflows are triggered and completed.
   - Look for the creation of a pod related to your workflow run. The pod name will typically include the runner set's name, such as `arc-runner-set-<random_id>`.

4. **Verify Runner Registration on GitHub:**

   To confirm that the runner is properly registered with GitHub and can be used by workflows, visit the **Settings** of your GitHub repository.

   - Navigate to **Settings > Actions > Runners**.
   - You should see the newly registered self-hosted runner listed in the runners section.
   - If your runner is registered successfully, the Actions Runner Controller has correctly connected to your GitHub repository.

5. **Inspect the Runner's Resource Usage:**

   As workflows run, it's important to monitor the resource usage of the runner pods. You can check this by running:

   ```bash
   kubectl top pod -n arc-runners
   ```

   - This will display resource usage (CPU and Memory) for the pods running in the `arc-runners` namespace.
   - You can use this information to ensure that your self-hosted runners are operating within expected resource limits.

This step ensures that your **Actions Runner Controller** is properly managing the lifecycle of self-hosted runners and that they are being used as expected within your GitHub workflows.

---

### Step 4: Trigger a Workflow Run Using the Self-Hosted Runner

Now that the **Actions Runner Controller** (ARC) is installed and your self-hosted runner is properly configured, it’s time to trigger a GitHub workflow that will utilize this runner. This step will guide you through the process of using the runner for your workflows.

1. **Create a GitHub Actions Workflow:**

   You need to create a workflow that specifies your self-hosted runner as the execution environment for the job. In your GitHub repository, navigate to the `.github/workflows` directory and create a new YAML file (e.g., `arc-runner-echo.yml`).

   Here's a sample workflow file that you can use:

   ```yaml
   name: ARC Runner - Echo

   on:
   push:
     paths:
       - '.github/workflows/arc-runner-echo.yml'
   workflow_dispatch:

   jobs:
   run:
     runs-on: arc-runner-set
     steps:
       - run: echo "🎉 This job uses runner scale set runners!"
   ```

   - The key part here is the `runs-on: [arc-runner-set]` line, which specifies that the job should run on the self-hosted runner set managed by the ARC.

2. **Commit and Push the Workflow:**

   After creating the workflow file, commit and push the changes to the repository.

   ```bash
   git add .
   git commit -m "Add workflow to use arc-runner-set"
   git push origin main
   ```

   - Pushing the changes will trigger the workflow since it listens to the `push` event on the `main` branch.

3. **Monitor the Workflow Run:**

   After pushing the changes, go to the **Actions** tab in your GitHub repository.

   - You should see the workflow running, as it’s triggered by your push to the `main` branch.
   - Click on the running workflow to view the logs and check which runner is being used.

4. **Verify the Self-Hosted Runner Usage:**

   Inside the logs of the workflow, check for the section that shows which runner was used to execute the job.

   - If everything is set up correctly, you should see that the job is running on the self-hosted runner in your AKS cluster. The log should show something like:

   ```yaml
   Running on runner-abc123 in the Arc cluster.
   ```

   This indicates that the job is using the runner hosted in your AKS cluster.

5. **Verify the Pod Creation in AKS:**

   While the workflow is running, go back to your terminal and check the `arc-runners` namespace for the newly created runner pod:

   ```bash
   kubectl get pods -n arc-runners
   ```

   - You should see a new pod created by the **Actions Runner Controller** for the job. The pod name will typically include the name of the runner set and a random identifier (e.g., `arc-runner-set-xxxx`).

6. **Check the Workflow Completion:**

   Once the workflow completes, go back to the **Actions** tab on GitHub and check the status of the workflow run.

   - If the workflow run completes successfully, it means the self-hosted runner was successfully used for the job, and the ARC managed the pod creation and execution.
   - Review the logs to ensure the job ran as expected.

This step verifies that your self-hosted runner is correctly integrated into your GitHub Actions workflows, and that the **Actions Runner Controller** is managing the runner pods in your AKS cluster as expected.

---

### Step 5: Review the Workflow Logs and Runner Details

After the workflow completes, it's essential to review the logs to ensure everything executed as expected. This step will guide you through checking the workflow logs in GitHub Actions and also inspecting the runner details to confirm the process is running smoothly.

---

1. **Navigate to the Actions Tab:**

   Go to the **Actions** tab in your GitHub repository. This tab shows a list of all the workflows that have been triggered in your repository.

2. **Select the Latest Workflow Run:**

   - Find and select the most recent run of the workflow you triggered in Step 4.
   - The workflow should be named according to the YAML file you created (e.g., **Use Self-Hosted Runner**).
   - If the workflow is still running, it will be marked as "In Progress." If it has completed, it will show as "Completed."

3. **Review the Workflow Run Summary:**

   In the **workflow run** details, you will see a summary of the jobs, steps, and status. Each job (e.g., `build`) will have a green checkmark if it succeeded, or a red X if it failed.

4. **Examine the Job Logs:**

   - Click on the job (e.g., `build`) to expand the details and see logs for each step.
   - Review the logs for each step to ensure that everything worked as expected.
     - Look for the **Checkout code**, **Set up .NET**, and **Build project** steps to see if they completed without errors.
   - Ensure that the self-hosted runner executed successfully and did not encounter issues. If there are any issues, errors will be displayed in the logs.

   Example of a successful log for the runner could be:

   ```plaintext
   Running on runner-abc123 in the Arc cluster.
   ```

   This confirms that the workflow ran on your self-hosted runner.

5. **Verify the Runner Usage:**

   The logs will also confirm which runner was used to execute the job. Look for a log entry similar to the following:

   ```plaintext
   Run on self-hosted runner: arc-runner-set-xyz123
   ```

   This shows that the workflow ran on the self-hosted runner in your AKS cluster managed by the Actions Runner Controller.

6. **Monitor the Runner Pod Lifecycle:**

   You can also verify the lifecycle of the runner pod that executed the job. In the **arc-runners** namespace, check for the pod that was created during the workflow:

   ```bash
   kubectl get pods -n arc-runners
   ```

   The pod associated with the workflow run should appear, and after the workflow completes successfully, the pod will likely be deleted automatically.

7. **Inspect the Runner Pod Logs (Optional):**

   If you need to investigate further, you can also inspect the logs of the specific pod that was used to execute the job:

   - First, identify the name of the runner pod:

     ```bash
     kubectl get pods -n arc-runners
     ```

   - Then, view the logs of the specific pod:

     ```bash
     kubectl logs <pod-name> -n arc-runners
     ```

   - This will display the logs for the pod where the workflow ran, which can help diagnose any issues with the runner or the execution environment.

By reviewing the workflow logs and checking the runner pod details, you ensure that your self-hosted runners are being used correctly and that there are no issues with your GitHub Actions workflows.

---

### Step 7: Monitor the Workflow Jobs in Azure Portal

In this step, you will learn how to monitor the job execution of your GitHub Actions workflows directly within the **Azure Portal**, where your AKS (Azure Kubernetes Service) cluster is running. By using the Azure Portal, you can get insights into the performance and health of your runner pods and ensure that everything is functioning as expected.

---

1. **Access the Azure Portal:**

   - Go to the [Azure Portal](https://portal.azure.com/) and sign in with your Azure account.
   - Navigate to the **AKS** resource where your cluster is hosted.
   - In the **AKS Cluster** dashboard, you can monitor various metrics related to your AKS cluster's performance and health.

2. **View AKS Cluster Monitoring:**

   In the **AKS cluster** dashboard:

   - **Navigate to the Monitoring section** by clicking on the **Monitoring** tab in the left-hand pane.
   - Under **Monitoring**, you'll see options like **Insights**, **Logs**, **Metrics**, etc.

   The **Insights** section is especially helpful because it provides a detailed view of your cluster's performance, node status, and pod health.

   **Note**: Ensure that you have enabled **Azure Monitor for containers** when setting up your AKS cluster, as this feature provides visibility into the metrics and logs for your containerized workloads.

3. **View Container Insights:**

   - Click on **Insights** under the **Monitoring** section. This will open up the monitoring dashboard for your AKS cluster.
   - In **Insights**, you’ll see various metrics related to your Kubernetes workload, including the **CPU** and **Memory usage** for your nodes and pods.
   - To get more details about the pods running your self-hosted GitHub runners, navigate to the **Pods** tab.
   - You should see the pods associated with your **Actions Runner Controller** in the `arc-runners` namespace.
     - The pods should have names like `arc-runner-set-<random-id>`, where the `arc-runner-set` corresponds to the self-hosted runners.
   - You can click on individual pods to see detailed metrics like CPU, memory usage, network IO, and logs.

4. **Use Logs for Troubleshooting:**

   - In the **Logs** section of **Azure Monitor**, you can write custom queries to fetch logs for your AKS cluster.
   - To monitor logs for your GitHub Actions runner pods, you can query the container logs associated with your runner pods.

     Example query to view logs from the runner pods:

     ```kusto
     ContainerLog
     | where ClusterName == "<your-aks-cluster-name>" and ContainerID contains "arc-runner-set"
     | sort by TimeGenerated desc
     ```

   - This will provide logs specifically related to the GitHub Actions runner pods. You can filter further based on the specific pod names, status, or any errors you want to track.

5. **Monitor Pod Status and Health:**

   - In the **Pods** section under **Insights**, you can monitor the status of each runner pod.
   - Look for any pods that might have failed or are in a **CrashLoopBackOff** state. These could indicate that something went wrong with a runner pod.
   - If any of your runner pods are stuck in an error state, you can examine the **logs** of that pod or use the **kubectl describe pod** command to get more details about the failure.

6. **Monitor Resource Usage:**

   - Azure provides insights into the resource consumption of each node and pod in the AKS cluster. In the **Metrics** section, you can set up monitoring for:
     - **CPU and Memory usage**: This helps to ensure that your runner pods have sufficient resources to execute jobs efficiently.
     - **Disk and Network I/O**: These metrics are useful for identifying potential bottlenecks in your runner pods.
   - By monitoring resource usage, you can proactively scale your AKS cluster or troubleshoot performance issues related to the runners.

7. **Set Up Alerts (Optional):**

   - You can set up alerts in **Azure Monitor** to be notified about any anomalies, such as high CPU usage, memory consumption, or failed pod health checks.
   - To set up alerts:
     - Go to the **Alerts** section in **Azure Monitor**.
     - Click on **+ New alert rule**.
     - Define the condition (e.g., a pod failing or CPU usage exceeding a threshold).
     - Set the action, such as sending an email or triggering a webhook, whenever the alert condition is met.

---

By monitoring the jobs in the **Azure Portal**, you ensure the health of your GitHub Actions runner pods and the performance of your workflows. The **Azure Monitor** and **Container Insights** features provide powerful tools to track metrics, resource usage, and logs related to your AKS-based self-hosted runners.

---

## Troubleshooting

While setting up GitHub Actions with self-hosted runners in AKS, you may encounter a few common issues. Here are some troubleshooting tips for resolving them:

#### 1. **Error: "Resource not accessible by personal access token" (PAT Issue)**

**Symptoms:**

- When trying to register the runner, you might see an error like:  
  `failed to get runner registration token on refresh: github api error: StatusCode 403`
- The runner pods fail to create or the job doesn't execute.

**Solution:**

- This error usually occurs because the **Personal Access Token (PAT)** doesn't have the required permissions for the repository or organization.
- **Ensure your PAT has the correct scopes**:
  - `repo` (Full control of private repositories)
  - `workflow` (To manage GitHub Actions workflows)
  - `read:org` (To access organizational data)
- You can create a new PAT with the necessary scopes by following [GitHub's instructions on creating a PAT](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token).
- After updating the PAT, **update the secret** in your Kubernetes secret or GitHub Actions configuration and trigger the workflow again.

#### 2. **Error: "Runner pods are not starting in AKS"**

**Symptoms:**

- The runner pods are not created or remain in the **Pending** state indefinitely.
- No runner containers are appearing in the AKS cluster.

**Solution:**

- Check if the **Actions Runner Controller** is running correctly in the AKS cluster by inspecting the controller pods. Use `kubectl get pods -n <namespace>` to verify the pod status.
- If the controller is running, check the logs for any errors:

  ```bash
  kubectl logs <controller-pod-name> -n <namespace>
  ```

- Ensure that your AKS cluster has enough resources (CPU, memory) to schedule the runner pods. If your cluster is under-provisioned, scale up the nodes or adjust resource limits for the runners.
- Check the **GitHub repository** and ensure that the repository’s settings allow the self-hosted runners to be registered (i.e., the repository is not restricted from accepting external runners).

#### 3. **Error: "Unable to fetch required container images"**

**Symptoms:**

- Errors related to downloading or accessing the container images used for GitHub Actions runners (e.g., `oci://ghcr.io/actions/actions-runner`).
- Pulling the container images results in a timeout or failure.

**Solution:**

- Verify that your **AKS cluster** has internet access to pull images from the GitHub Container Registry.
- If you are using private container images, ensure that the necessary **credentials** (e.g., a service principal or managed identity) are configured in AKS to allow pulling from private registries.
- For public images, ensure there are no network restrictions in your Azure Virtual Network that would prevent accessing external repositories.

#### 4. **Error: "No jobs were found to run" or "No available runners"**

**Symptoms:**

- When triggering a workflow, GitHub does not find any available runners in your AKS cluster.
- The workflow status remains in the **queued** state without running.

**Solution:**

- Verify that the runner pods in the AKS cluster are running. You can check the pods with:

  ```bash
  kubectl get pods -n <namespace>
  ```

- Make sure the self-hosted runner is registered with your GitHub repository or organization. You can verify this by going to the **Actions** tab in your GitHub repository and ensuring that the self-hosted runner is listed under **Runners**.
- If there is a misconfiguration with your **GitHub Actions Runner Controller**, review its logs for any errors or issues related to registration.

#### 5. **Issue: Scaling of Runner Pods is Not Working**

**Symptoms:**

- The number of runner pods does not increase or decrease based on the workload.

**Solution:**

- Ensure that the **Actions Runner Controller** has been correctly configured with **scaling rules**.
- If you are using the **AutoscalingRunnerSet** resource, check that the **replica count** is set correctly and that the `minReplicas` and `maxReplicas` settings are appropriate for the expected workload.
- Check the logs for the **AutoscalingRunnerSet** controller to verify if there are any issues related to scaling.

---

### Summary

In this lab, you successfully set up **GitHub Actions** with **self-hosted runners** on **Azure Kubernetes Service (AKS)** using the **Actions Runner Controller**. The key steps involved:

1. **Installing the Actions Runner Controller** on AKS using Helm, which helps manage and scale self-hosted runners dynamically.
2. **Configuring a GitHub repository** to work with the self-hosted runners, ensuring that workflows can run on the AKS-based runners.
3. **Monitoring runner activity** through both the GitHub Actions UI and Azure Portal to track the execution of jobs.
4. **Troubleshooting common issues** such as problems with Personal Access Tokens (PATs), scaling, and runner availability, ensuring smooth operation of the self-hosted runners.

By leveraging AKS to run GitHub Actions workflows, you can automate your CI/CD pipelines at scale, taking advantage of Kubernetes' powerful scaling capabilities. You can now efficiently run and manage workflows on your own infrastructure while maintaining the flexibility to scale resources as needed.
