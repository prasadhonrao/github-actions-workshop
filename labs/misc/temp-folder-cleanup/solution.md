## Solution: Temp Folder Cleanup

```yaml
name: Misc - Temp Folder Cleanup

on:
  push:
    branches:
      - main
    paths:
      - '.github/workflows/misc-temp-folder-cleanup.yml'
  workflow_dispatch: # Allows manual triggering of the workflow

jobs:
  cleanup-temp:
    runs-on: self-hosted # Uses the self-hosted runner

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      # Step 1: Check if the runner is on Windows OS using PowerShell
      - name: Check OS
        run: |
          echo "Running on OS: $env:RUNNER_OS"
        shell: pwsh

      # Step 2: List all folders in C:\temp (only on Windows, and if C:\temp exists)
      - name: List all folders in C:\temp
        if: ${{ runner.os == 'Windows' }} && (exists 'C:\temp')
        run: |
          echo "Listing all folders in C:\temp..."
          # PowerShell command to list directories in C:\temp
          Get-ChildItem -Path C:\temp -Directory | Select-Object -ExpandProperty Name
        shell: pwsh

      # Step 3: Delete all folders in C:\temp
      - name: Delete all folders in C:\temp
        if: ${{ runner.os == 'Windows' }} && (exists 'C:\temp')
        run: |
          echo "Deleting all folders in C:\temp..."
          # PowerShell command to remove all directories in C:\temp
          Get-ChildItem -Path C:\temp -Directory | Remove-Item -Recurse -Force
        shell: pwsh

      # Step 4: If C:\temp doesn't exist, log a message and skip
      - name: Skip Cleanup if C:\temp doesn't exist
        if: ${{ runner.os == 'Windows' }} && !(exists 'C:\temp')
        run: |
          echo "C:\temp does not exist. Skipping cleanup step."
        shell: pwsh
```
