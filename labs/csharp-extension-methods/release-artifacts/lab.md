## Lab: C# Extension Methods - Release Artifacts

This lab will show you how to create a GitHub Actions workflow to test a C# Extension Methods project, create a NuGet package, and publish it to both GitHub Packages and NuGet.org.

> Duration: 30-45 minutes

## Instructions

1. Navigate to the `src\dotnet` directory of the repository where you will find the `CSharp.ExtensionMethods` project. This folder contains the C# Extension Methods project and the `CSharp.ExtensionMethods.Tests` project.

2. Note that the `CSharp.ExtensionMethods` project contains the extension methods and the `CSharp.ExtensionMethods.Tests` project has a reference to `Csharp.ExtensionMethods` project and contains the unit tests for the extension methods.

3. Open the integrated terminal in Visual Studio Code, navigate to `CSharp.ExtensionMethods` sub-directory and run the following command to build the `CSharp.ExtensionMethods` project:

   ```bash
   dotnet build
   ```

4. Now goto `CSharp.ExtensionMethods.Tests` directory and run the following command to run the unit tests:

   ```bash
   dotnet test
   ```

5. Now we will create a GitHub Actions workflow to build and test the project. Create a new file named `csharp-extension-methods-release-artifacts.yml` in the `.github/workflows` directory and add the following content:

   ```yaml
   name: CSharp Extension Methods Release Artifacts

   on:
     workflow_dispatch:

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
         - name: Check out repository code
           uses: actions/checkout@v4

         - name: Setup .NET Core
           uses: actions/setup-dotnet@v1
           with:
             dotnet-version: 8.0.x

         - name: Build CSharp.ExtensionMethods
           run: dotnet build --configuration Release
           working-directory: ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods

         - name: Build CSharp.ExtensionMethods.Tests
           run: dotnet build --configuration Release
           working-directory: ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods.Tests

         - name: Run Unit Tests
           run: dotnet test --no-restore --verbosity normal
           working-directory: ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods.Tests

         # Create a GitHub Release
         - name: Create GitHub Release
           id: create_release
           uses: actions/create-release@v1
           with:
             tag_name: v1.0.${{ github.run_number }}
             release_name: 'Release v1.0.${{ github.run_number }}'
             body: 'Release of CSharp.ExtensionMethods NuGet package'
           env:
             GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
   ```

6. Commit the changes and push them to the repository.

7. Navigate to the "Actions" tab in your repository to view the workflow runs.

8. Click on the latest workflow run to view the details.

9. Next, we will enhance the workflow to create a NuGet package for the `CSharp.ExtensionMethods` project. Add the following steps to the existing workflow:

   ```yaml
   - name: Create NuGet Package
     run: dotnet pack --configuration Release
     working-directory: ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods
   ```

10. Commit the changes and push them to the repository.

11. Navigate to the "Actions" tab in your repository to view the workflow runs.

12. Click on the latest workflow run to view the details.

13. Next, we will publish the NuGet package to GitHub Packages. Add the following steps to the existing workflow.

    ```yaml
    - name: Publish NuGet Package to GitHub Packages
      run: dotnet nuget push ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods/bin/Release/*.nupkg --source "https://nuget.pkg.github.com/${{ github.repository_owner }}/index.json" --api-key ${{ secrets.GITHUB_TOKEN }} --skip-duplicate
    ```

14. Commit the changes and push them to the repository.

15. Navigate to the "Actions" tab in your repository to view the workflow runs.

16. Click on the latest workflow run to view the details.

17. Next, we will publish the NuGet package to NuGet.org. Create a new NuGet API key by following the instructions [here](https://docs.microsoft.com/en-us/nuget/quickstart/create-and-publish-a-package-using-the-dotnet-cli#publish-the-package). Add the NuGet API key as a secret named `NUGET_API_KEY` in the repository.

18. Add the following steps to the existing workflow:

    ```yaml
    - name: Publish NuGet Package to NuGet.org
      run: dotnet nuget push ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods/bin/Release/*.nupkg --source "https://api.nuget.org/v3/index.json" --api-key ${{ secrets.NUGET_API_KEY }} --skip-duplicate
    ```

19. Commit the changes and push them to the repository.

20. Navigate to the "Actions" tab in your repository to view the workflow runs.

21. Click on the latest workflow run to view the details.

22. Next we will create a GitHub Release for the NuGet package. Add the following steps to the existing workflow:

    ```yaml
    # Create a GitHub Release
    - name: Create GitHub Release
      id: create_release
      uses: actions/create-release@v1
      with:
        tag_name: v1.0.${{ github.run_number }}
        release_name: 'Release v1.0.${{ github.run_number }}'
        body: 'Release of CSharp.ExtensionMethods NuGet package'
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    ```

23. Commit the changes and push them to the repository.

24. Navigate to the "Actions" tab in your repository to view the workflow runs.

25. Click on the latest workflow run to view the details.

26. You have successfully created a GitHub Actions workflow to test a C# Extension Methods project, create a NuGet package, and publish it to both GitHub Packages and NuGet.org.

27. Go to the "Packages" tab in your repository to view the published NuGet package.

28. Navigate to the NuGet.org website to view the published NuGet package.

29. You can now use the published NuGet package in your projects.

## Summary

In this lab, you created a GitHub Actions workflow to test a C# Extension Methods project, create a NuGet package, and publish it to both GitHub Packages and NuGet.org.

## References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [NuGet CLI Documentation](https://docs.microsoft.com/en-us/nuget/reference/cli-reference/cli-reference)
- [GitHub Packages Documentation](https://docs.github.com/en/packages)
