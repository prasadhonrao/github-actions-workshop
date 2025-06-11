#!/bin/bash
# CLI automation script for ARC Runner Lab
# This script automates the AKS and ARC setup as described in lab.md
# Define all variables at the top for easy modification

# Variables
RESOURCE_GROUP="rg-github-actions-workshop"
LOCATION="uksouth"
AKS_CLUSTER="aks-arc-lab-cluster"
NAMESPACE="ns-arc"
INSTALLATION_NAME="arc-runner-set"
GITHUB_CONFIG_URL="https://github.com/prasadhonrao/github-actions-workshop"
GITHUB_PAT=""  # <-- Replace with your actual GitHub PAT

# 1. Install Required CLI Tools (assumes you have curl and sudo access)
# Uncomment the following lines if you want to install tools automatically
# echo "Installing Azure CLI..."
# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
# echo "Installing kubectl..."
# az aks install-cli
# echo "Installing Helm..."
# curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# 2. Log in to Azure
az login

# 2.1 Assign AKS admin role to Service Principal (required for GitHub Actions to access AKS)
# Automatically get the SP App ID from an Azure AD Application display name
SP_DISPLAY_NAME="sp-github-actions-workshop"
SP_NAME_OR_ID=$(az ad sp list --display-name "$SP_DISPLAY_NAME" --query "[0].appId" -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)

# Ensure the resource group and AKS cluster exist before assigning the role
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"
az aks create \
    --resource-group "$RESOURCE_GROUP" \
    --name "$AKS_CLUSTER" \
    --node-count 2 \
    --generate-ssh-keys || true

# Assign the AKS Cluster Admin Role to the Service Principal. Set it using portal if it fails.
az role assignment create \
  --assignee "$SP_NAME_OR_ID" \
  --role "Azure Kubernetes Service Cluster Admin Role" \
  --scope "/subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP/providers/Microsoft.ContainerService/managedClusters/$AKS_CLUSTER" || true

# 5. Get AKS Credentials
az aks get-credentials --resource-group "$RESOURCE_GROUP" --name "$AKS_CLUSTER"

# 6. Verify Cluster Nodes
kubectl get nodes

# 7. Create Namespace for ARC
kubectl create namespace "$NAMESPACE" || true

# 8. Install Actions Runner Controller (ARC)
helm upgrade --install arc \
    --namespace "$NAMESPACE" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

# 9. Create GitHub Token Secret
kubectl create secret generic github-token \
    --namespace="$NAMESPACE" \
    --from-literal=github_token="$GITHUB_PAT" || true

# 10. Install Runner Set
helm upgrade --install "$INSTALLATION_NAME" \
    --namespace "$NAMESPACE" \
    --create-namespace \
    --set githubConfigUrl="$GITHUB_CONFIG_URL" \
    --set githubConfigSecret.github_token="$GITHUB_PAT" \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set

# 11. Show ARC and Runner Pods
kubectl get pods -n "$NAMESPACE"

# 12. (Optional) Show resource usage
# kubectl top pod -n "$NAMESPACE"

