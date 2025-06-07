## Solution: Creating a Shared Workflow to Deploy an ASP.NET Web App to Azure

```yaml
name: Shared Workflow Azure Web App Deploy

on:
  workflow_call:
    inputs:
      AZURE_WEBAPP_PACKAGE_PATH:
        required: true
        type: string
      AZURE_WEBAPP_NAME:
        required: true
        type: string
    secrets:
      AZURE_SERVICE_PRINCIPAL:
        required: true

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Download artifact from build job
        uses: actions/download-artifact@v4
        with:
          name: webapp
          path: ${{ inputs.AZURE_WEBAPP_PACKAGE_PATH }}
      - name: Azure Login
        uses: azure/login@v2
        with:
          creds: ${{ secrets.AZURE_SERVICE_PRINCIPAL }}
      - name: Deploy to Azure WebApp
        uses: azure/webapps-deploy@v2
        with:
          app-name: ${{ inputs.AZURE_WEBAPP_NAME }}
          package: ${{ inputs.AZURE_WEBAPP_PACKAGE_PATH }}
```
