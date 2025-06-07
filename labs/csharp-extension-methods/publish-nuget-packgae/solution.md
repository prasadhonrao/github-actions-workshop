## Solution: C# Extension Methods - Publish NuGet Package

```yaml
name: CSharp Extension Methods - Publish NuGet Package

on:
  workflow_dispatch:
  push:
    paths:
      - 'src/dotnet/CSharp.ExtensionMethods/**'
jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write
    env:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
    steps:
      - name: Checkout Code
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

      - name: Create NuGet Package
        run: dotnet pack --configuration Release
        working-directory: ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods

      - name: Publish NuGet Package to GitHub Packages
        run: dotnet nuget push ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods/bin/Release/*.nupkg --source "https://nuget.pkg.github.com/${{ github.repository_owner }}/index.json" --api-key ${{ secrets.GITHUB_TOKEN }} --skip-duplicate

      - name: Publish NuGet Package to NuGet.org
        run: dotnet nuget push ./src/dotnet/CSharp.ExtensionMethods/CSharp.ExtensionMethods/bin/Release/*.nupkg --source "https://api.nuget.org/v3/index.json" --api-key ${{ secrets.NUGET_API_KEY }} --skip-duplicate
```
