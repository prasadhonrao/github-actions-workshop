## Lab: Speed Up Node.js CI with GitHub Actions Cache

## Introduction

In this lab, you will learn how to use caching in GitHub Actions to speed up a Node.js application's build by avoiding redundant dependency installation. You'll compare two workflows: one without caching and one using the `actions/cache` action.

You’ll use the existing `express-hello-world` Node.js project located at `/src/javascript/express-hello-world`

> **Estimated Duration**: 20–30 minutes

---

## Instructions

### Step 1: Open your repository

1. Navigate to the repository containing the `express-hello-world` project.
2. Ensure the following file exists `
src/javascript/express-hello-world/package.json`
3. If needed, test the app locally to verify it's working:

```bash
cd src/javascript/express-hello-world
npm install
node server.js
```

---

### Step 2: Create the workflow **without cache**

1. In the GitHub web UI, go to the **Code** tab.

2. Navigate to the `.github/workflows` directory. Create the folders if they don’t exist:

   - Click **Add file** > **Create new file**
   - Name the file: `.github/workflows/build-no-cache.yml`

3. Paste the following content:

   ```yaml
   name: Express Server without cache

   on:
     workflow_dispatch:

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
         - uses: actions/checkout@v3

         - name: Setup Node.js
           uses: actions/setup-node@v3
           with:
             node-version: '18'

         - name: Install dependencies
           run: |
             cd src/javascript/express-hello-world
             npm install

         - name: Show installed packages
           run: |
             cd src/javascript/express-hello-world
             npm list
   ```

4. Scroll down and click **Commit new file**.

---

### Step 3: Run the workflow and check time taken

1. Go to the **Actions** tab.
2. Click on the **Node.js CI without cache** workflow.
3. Click **Run workflow** > **Run workflow** (manually trigger it).
4. After it completes, expand the **Install dependencies** step and note the duration.

---

### Step 4: Create the workflow **with cache**

1. In the same `.github/workflows` folder, create another file named `build-with-cache.yml`

2. Paste the following content:

   ```yaml
   name: Express Server with cache

   on:
     workflow_dispatch:

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
         - uses: actions/checkout@v3

         - name: Setup Node.js
           uses: actions/setup-node@v3
           with:
             node-version: '18'

         - name: Cache npm dependencies
           uses: actions/cache@v3
           with:
             path: ~/.npm
             key: ${{ runner.os }}-node-${{ hashFiles('src/javascript/express-hello-world/package-lock.json') }}
             restore-keys: |
               ${{ runner.os }}-node-

         - name: Install dependencies
           run: |
             cd src/javascript/express-hello-world
             npm install

         - name: Show installed packages
           run: |
             cd src/javascript/express-hello-world
             npm list
   ```

3. Commit the file.

---

### Step 5: Run the workflow twice and compare

1. Navigate to the **Actions** tab.

2. Run the **Node.js CI with cache** workflow manually.

   - First run: Installs dependencies and creates the cache.
   - Second run: Restores the cache and speeds up installation.

3. Expand the **Install dependencies** step in both runs and compare durations.

---

## Summary

In this lab, you created two GitHub Actions workflows for a Node.js app — one with caching and one without. You observed how dependency installation time was significantly reduced when using the `actions/cache` step with `.npm` as the cache path.

Caching is useful when:

- Dependencies are downloaded often
- Builds or installs are expensive
- You want faster workflows on repeated runs

---

## Additional Resources

- [actions/cache documentation](https://github.com/actions/cache)
- [Caching dependencies for Node.js](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
