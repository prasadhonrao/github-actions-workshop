## Solution: React Tic-Tac-Toe CI / CD Workflow

```yaml
name: React Tic-Tac-Toe CI/CD

on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/caching-workflow.yml'
      - 'src/react/react-tic-tac-toe/**'

env:
  DOCKER_IMAGE: prasadhonrao/react-tic-tac-toe
  CONTEXT_PATH: ./src/react/react-tic-tac-toe

jobs:
  build-and-push:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4
        with:
          submodules: true # Fetch the submodules

      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'

      # Step 3: Restore Cache
      - name: Restore npm cache
        uses: actions/cache@v3
        with:
          path: ~/.npm
          key: ${{ runner.os }}-node-${{ hashFiles('${{ env.CONTEXT_PATH }}/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-node-

      - name: Install Dependencies
        run: npm ci
        working-directory: ${{ env.CONTEXT_PATH }}

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v2

      - name: Log in to Docker Hub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build and Push Docker Image
        run: |
          cd ${{ env.CONTEXT_PATH }}
          TAG=${{ github.sha }}
          docker build -t ${{ env.DOCKER_IMAGE }}:$TAG -t ${{ env.DOCKER_IMAGE }}:latest .
          docker push ${{ env.DOCKER_IMAGE }}:$TAG
          docker push ${{ env.DOCKER_IMAGE }}:latest
```
