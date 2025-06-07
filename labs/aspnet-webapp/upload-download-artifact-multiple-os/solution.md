## Solution: ASP.NET Web App - Upload and Download Artifacts Across Multiple OS

```yaml
name: ASP.NET Web App - Upload - Download Artifact Multiple OS

on:
  push:
    paths:
      - '.github/workflows/aspnet-webapp-upload-download-artifact-multiple-os.yml'
      - 'src/dotnet/WebApp/**'
  workflow_dispatch:

jobs:
  build-and-upload:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    defaults:
      run:
        working-directory: ./src/dotnet/WebApp
        shell: bash # Use Bash shell for all steps
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
        run: |
          # Set the publish directory based on OS
          if [[ "$RUNNER_OS" == "Windows" ]]; then
            PUBLISH_DIR="${{ runner.temp }}\\webapp"
          else
            PUBLISH_DIR="${{ runner.temp }}/webapp"
          fi

          # Publish the application
          echo "Publishing to $PUBLISH_DIR"
          mkdir -p "$PUBLISH_DIR"
          dotnet publish -c Release --output "$PUBLISH_DIR"

          # Verify contents
          echo "Contents of $PUBLISH_DIR:"
          ls "$PUBLISH_DIR"

      - name: Upload Artifact
        uses: actions/upload-artifact@v4.3.6
        with:
          name: 'aspnet-web-app-${{ runner.os }}'
          path: ${{ runner.temp }}/webapp # Temporary directory used for publishing.
  download:
    strategy:
      matrix:
        os: [ubuntu-latest, windows-latest, macos-latest]
    runs-on: ${{ matrix.os }}
    needs: build-and-upload
    defaults:
      run:
        shell: bash # Consistent shell for all OSes
    steps:
      - name: Download Artifact
        uses: actions/download-artifact@v4.1.8
        with:
          name: 'aspnet-web-app-${{ runner.os }}'

      - name: List Files in Artifact
        run: |
          echo "Listing files in the downloaded directory:"
          ls -R $GITHUB_WORKSPACE
```
