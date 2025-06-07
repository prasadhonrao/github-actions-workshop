## Solution: ASP.NET Web App Upload - Download Artifact

```yaml
name: ASP.NET Web App - Download Artifact

on:
  push:
    paths:
      - '.github/workflows/aspnet-webapp-download-artifact.yml'
      - 'src/dotnet/WebApp/**'
  workflow_dispatch:

jobs:
  build-and-upload:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./src/dotnet/WebApp
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4.1.7

      - name: Set up .NET Core
        uses: actions/setup-dotnet@v4.0.1
        with:
          dotnet-version: '8.x'

      - name: Build Code
        run: dotnet build --configuration Release

      - name: Publish Code
        run: dotnet publish -c Release --property:PublishDir="${{runner.temp}}/webapp"

      - name: Upload Artifact
        uses: actions/upload-artifact@v4.3.6
        with:
          name: aspnet-web-app # Artifact name
          path: ${{runner.temp}}/webapp
          retention-days: 7 # Number of days to keep the artifact. Default is 90 days or configured value in the repository settings -> Actions permissions -> Artifact and logs retention

  download:
    runs-on: ubuntu-latest
    needs: build-and-upload
    steps:
      - name: Download Artifact
        uses: actions/download-artifact@v4.1.8
        with:
          name: aspnet-web-app # Artifact name
      - name: List Files in Artifact
        run: |
          ls -al
        shell: bash
```
