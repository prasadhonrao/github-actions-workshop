## Solution: Publish ASP.NET Web API as a GitHub Package

```yaml
name: ASP.NET Web API Publish GitHub Package
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/aspnet-webapi-publish-github-package.yml'
      - 'src/dotnet/Weather.WebApi/**'

env:
  GITHUB_PACKAGE_NAME: ghcr.io/prasadhonrao/aspnet-weather-webapi

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write # Required for creating packages
    defaults:
      run:
        working-directory: ./src/dotnet/Weather.WebApi
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build ASP.NET Weather Web API
        run: dotnet build

      - name: Build Local Docker Image
        run: docker image build -t aspnet-weather-webapi .

      - name: Login to GitHub Container Registry
        uses: docker/login-action@v3
        with:
          registry: ghcr.io # GitHub Container Registry. Default is docker.io
          username: ${{ github.repository_owner }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Tag Image to latest
        run: docker tag aspnet-weather-webapi ${{ env.GITHUB_PACKAGE_NAME }}:latest

      - name: Tag Image to branch
        run: |
          BRANCH_NAME=${{ github.ref_name }}
          docker tag aspnet-weather-webapi ${{ env.GITHUB_PACKAGE_NAME }}:$BRANCH_NAME

      - name: Push Image with latest tag to GitHub Container Registry
        run: docker push ${{ env.GITHUB_PACKAGE_NAME }}:latest

      - name: Push Image with branch tag to GitHub Container Registry
        run: |
          BRANCH_NAME=${{ github.ref_name}}
          docker push ${{ env.GITHUB_PACKAGE_NAME }}:$BRANCH_NAME
```
