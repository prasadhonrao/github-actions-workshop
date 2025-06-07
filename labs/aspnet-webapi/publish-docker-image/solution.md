## Solution: Publish ASP.NET Web API as a Docker Image

```yaml
name: ASP.NET Web API Publish Docker Image
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/aspnet-webapi-publish-docker-image.yml'
      - 'src/dotnet/Weather.WebApi/**'

env:
  DOCKER_IMAGE: prasadhonrao/aspnet-weather-webapi

jobs:
  build:
    runs-on: ubuntu-latest
    defaults:
      run:
        working-directory: ./src/dotnet/Weather.WebApi
    permissions:
      contents: read
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build ASP.NET Weather Web API
        run: dotnet build

      - name: Build Local Docker Image
        run: docker image build -t aspnet-weather-webapi .

      - name: List Docker Images
        run: docker image ls

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Tag Image to latest
        run: docker tag aspnet-weather-webapi ${{ env.DOCKER_IMAGE }}:latest

      - name: Push Image with latest tag to Docker Hub Registry
        run: docker push ${{ env.DOCKER_IMAGE }}:latest

      - name: List Docker Images
        run: docker image ls
```
