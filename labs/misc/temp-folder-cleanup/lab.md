## Lab: Temp Folder Cleanup

---

### **Introduction**

In this lab, you will create a GitHub Actions workflow that automatically cleans up the `C:\temp` folder on a self-hosted Windows runner. The workflow will:

- Check if the runner is operating on a Windows OS.
- List the directories in the `C:\temp` folder if it exists.
- Delete the directories in `C:\temp`.
- Skip the cleanup if `C:\temp` doesn't exist.

> **Estimated Duration**: 10-15 minutes

---

### **Learning Objectives**

By the end of this lab, you will:

- Understand how to create and configure a GitHub Actions workflow to perform system maintenance tasks on a self-hosted Windows runner.
- Learn how to use PowerShell in GitHub Actions workflows for file system management.
- Gain experience in conditionally executing steps based on the environment (in this case, the OS).
- Understand how to skip steps in workflows when certain conditions are not met, ensuring smooth execution.

---

### **Directory Structure**

In your repository, you will create the following directory structure if it does not already exist:

```plaintext
.github/
└── workflows/
    └── misc-temp-folder-cleanup.yml
```

This folder will contain the workflow file where you will define the steps for cleaning up the `C:\temp` directory on the self-hosted runner.

---

### **Workflow File**

Create the workflow file `.github/workflows/misc-temp-folder-cleanup.yml` with the following content:

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

---

### **Workflow Details**

This workflow performs the following tasks:

1. **Checkout Repository**:

   - The `actions/checkout@v3` action is used to check out the repository so that subsequent steps can execute correctly.

2. **Check OS**:

   - The `Check OS` step ensures the runner is running on Windows by using PowerShell (`$env:RUNNER_OS`).

3. **List Folders in `C:\temp`**:

   - The workflow checks if `C:\temp` exists and, if it does, lists all the directories within it using the `Get-ChildItem` cmdlet.

4. **Delete Folders in `C:\temp`**:

   - If the `C:\temp` directory exists, the workflow recursively deletes all directories inside it.

5. **Skip Cleanup if `C:\temp` Doesn’t Exist**:
   - If `C:\temp` is not found, the workflow logs a message and skips the cleanup process.

---

### **Steps to Execute**

1. **Set Up the Workflow**:

   - Create the file `.github/workflows/misc-temp-folder-cleanup.yml` in your repository.
   - Copy the YAML content provided into the newly created file.

2. **Run the Workflow**:

   - Trigger the workflow manually using the `workflow_dispatch` event or by pushing changes to the workflow file in the `main` branch.

3. **Review the Logs**:

   - Navigate to the **Actions** tab in your repository to monitor the workflow run.
   - Check the logs for the outputs from each step. Look for confirmation of listed folders, deletion of directories, or a message about skipping cleanup.

---

### **Expected Outputs**

- If `C:\temp` exists and contains folders, the workflow will:
  1. List all the directories.
  2. Delete the directories.
- If `C:\temp` does not exist:
  - The workflow will log a message and skip the cleanup process.

Example log output for the `List all folders in C:\temp` step:

```plaintext
Listing all folders in C:\temp...
folder1
folder2
folder3
```

Example log output for the `Delete all folders in C:\temp` step:

```plaintext
Deleting all folders in C:\temp...
Successfully deleted folder1
Successfully deleted folder2
Successfully deleted folder3
```

---

### **Additional Notes**

- **Self-Hosted Runners**:

  - Ensure that the self-hosted runner has proper permissions to access and modify the `C:\temp` directory.
  - If the runner is running on a non-Windows OS, the steps will not execute as the workflow is configured specifically for Windows.

- **Skipping Steps**:

  - The workflow uses `if: ${{ runner.os == 'Windows' }} && !(exists 'C:\temp')` to skip the cleanup step if `C:\temp` doesn't exist, preventing failure and ensuring smooth execution.

- **Debugging**:
  - If any step fails, check the logs for errors related to file permissions or missing directories.

---

### **Conclusion**

In this lab, you have created a GitHub Actions workflow that automates the cleanup of the `C:\temp` folder on a self-hosted Windows runner. By using conditional checks and PowerShell commands, the workflow ensures efficient management of the file system, including listing and deleting directories while skipping steps when necessary. This demonstrates the power of GitHub Actions in automating system maintenance tasks.
