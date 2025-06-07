## Solution: ASP.NET Web API Build

```yaml
name: ASP.NET Web API Build
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/aspnet-webapi-build.yml'
      - 'src/dotnet/Weather.WebApi/**'
jobs:
  build:
    name: build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Build ASP.NET Weather Web API
        run: dotnet build
        working-directory: ./src/dotnet/Weather.WebApi
```
