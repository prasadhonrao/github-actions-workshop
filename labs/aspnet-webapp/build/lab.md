## Lab: Build ASP.NET Web App

## Introduction

In this lab, you will create a GitHub Actions workflow that builds and publishes an ASP.NET Core Web App. The workflow triggers on code changes in the `src/dotnet/WebApp/` directory and can also be run manually. You will also learn how to change the runner environment to macOS, Windows, or a self-hosted runner.

> **Estimated Duration**: 20–30 minutes

---

## Instructions

### Step 1: Set up your repository

1. Navigate to the GitHub repository where your ASP.NET Web App source code is located.

   - The web app should reside in the path: `src/dotnet/WebApp`.
   - If you don’t have this structure yet, create the folders and add a sample `.csproj` file and Program.cs to simulate the project.

---

### Step 2: Create the workflow file

1. In the repository, go to the **Code** tab.

2. Click **Add file** > **Create new file**.

3. Name the file: `.github/workflows/aspnet-webapp-build.yml`

4. Paste the following workflow YAML:

   ```yaml
   name: ASP.NET Web App Build

   on:
     push:
       paths:
         - 'src/dotnet/WebApp/**'
     workflow_dispatch:

   jobs:
     build:
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
   ```

5. Click **Commit new file** to save the workflow.

---

### Step 3: Understand the workflow

- **Triggers**:

  - On `push` to any file under `src/dotnet/WebApp/`
  - On manual execution via `workflow_dispatch`

- **Environment**: Runs on `ubuntu-latest` by default
- **Jobs**:

  1. **Checkout** the code
  2. **Set up** .NET 8 SDK
  3. **Build** the project in `Release` mode
  4. **Publish** the output to a temporary directory

---

### Step 4: Test the workflow

1. Make a small change to any file under `src/dotnet/WebApp/` and push it to GitHub.
2. Alternatively, go to the **Actions** tab and run the workflow manually using **Run workflow**.
3. View the workflow logs in the **Actions** tab.
4. Confirm successful execution of all steps.

---

### Step 5: Change the runner environment

You can change the runner by updating the `runs-on` property in the workflow.

#### a. Use a Windows runner

```yaml
runs-on: windows-latest
```

#### b. Use a macOS runner

```yaml
runs-on: macos-latest
```

#### c. Use a self-hosted runner

To use a self-hosted runner, make sure you've registered a runner in your repo/org. Then change:

```yaml
runs-on: self-hosted
```

You can also target a specific label if you've added one during runner setup:

```yaml
runs-on: [self-hosted, windows, x64]
```

> ✅ Tip: Self-hosted runners require manual setup. Refer to [GitHub Docs - Self-hosted runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners) for guidance.

---

### Step 6: Try with different runners (Optional)

1. Modify the workflow to use one of the alternative runners.
2. Commit the changes.
3. Re-run the workflow to observe platform-specific behavior.

   - On macOS or Windows, the behavior of SDK setup and file paths may differ slightly.

---

## Summary

In this lab, you created a workflow to build and publish an ASP.NET Core Web App using GitHub Actions. You learned how to:

- Trigger workflows on push and manual dispatch.
- Use different GitHub-hosted runners or a self-hosted runner.
- Automate your .NET project build process.

---

## Additional Resources

1. [GitHub Actions for .NET](https://docs.github.com/en/actions/automating-builds-and-tests/building-and-testing-net)
2. [Self-hosted Runners](https://docs.github.com/en/actions/hosting-your-own-runners/about-self-hosted-runners)
3. [.NET CLI - `dotnet build`](https://learn.microsoft.com/en-us/dotnet/core/tools/dotnet-build)
