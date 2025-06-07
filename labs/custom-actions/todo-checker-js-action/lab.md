## Lab: Create and Run a Custom JavaScript Action to Check TODO Comments in Code

### **Objective:**

In this lab, you will create a custom GitHub Action that scans your codebase for `TODO` comments and reports their location. You will integrate this action into a GitHub Actions workflow to automate checking for these comments whenever changes are pushed to your repository.

---

### **Prerequisites:**

- An existing GitHub repository (either personal or part of an organization).
- Basic understanding of GitHub Actions and workflows.
- Familiarity with JavaScript, Node.js, and regular expressions.

---

### **Steps:**

### **Step 1: Set Up the Custom GitHub Action Directory**

1. Navigate to your **existing GitHub repository** where you want to create the custom action.
2. Create the following directory structure inside the repository:

   ```bash
   mkdir -p .github/actions/todo-checker-javascript-action
   cd .github/actions/todo-checker-javascript-action
   ```

3. Inside the `.github/actions/todo-checker-javascript-action` directory, create the following files:
   - `action.yml`
   - `index.js`
   - `package.json`

---

### **Step 2: Define the Action Metadata (`action.yml`)**

The `action.yml` file defines the metadata for the GitHub Action.

Create the file `.github/actions/todo-checker-javascript-action/action.yml` with the following content:

```yaml
name: 'TODO Checker JavaScript Action'
description: 'Checks for TODO comments in your codebase.'
inputs:
  path:
    description: 'Path to the files to check'
    required: true
    default: './'
runs:
  using: 'node16'
  main: 'dist/index.js'
```

This file specifies that the action uses Node.js, and it runs the `index.js` script to perform the check. It also defines an input parameter `path`, which indicates the directory to search for `TODO` comments.

---

### **Step 3: Write the JavaScript Logic (`index.js`)**

Create the file `.github/actions/todo-checker-javascript-action/index.js` with the following code:

```javascript
const core = require('@actions/core');
const fs = require('fs');
const path = require('path');

// Function to get all files from a directory recursively
async function getAllFiles(dirPath) {
  let files = await fs.promises.readdir(dirPath, { withFileTypes: true });
  let filePaths = [];
  for (const file of files) {
    const filePath = path.join(dirPath, file.name);
    if (file.isDirectory()) {
      filePaths = filePaths.concat(await getAllFiles(filePath));
    } else {
      filePaths.push(filePath);
    }
  }
  return filePaths;
}

// Function to find TODO comments in files
async function findTodosInFiles(files) {
  const todoPattern = /\/\/\s*TODO:.*/g; // Pattern to find TODO comments
  let todos = [];

  for (const file of files) {
    const content = await fs.promises.readFile(file, 'utf-8');
    const matches = content.match(todoPattern);
    if (matches) {
      matches.forEach((todo, index) => {
        const line = content.split('\n').findIndex((line) => line.includes(todo)) + 1;
        todos.push({ file, todo: todo.trim(), line });
      });
    }
  }
  return todos;
}

// Main function to run the action
async function run() {
  try {
    const srcFolder = core.getInput('src-folder') || './src';
    const strictMode = core.getBooleanInput('strict') || false; // Fail workflow if true
    core.info(`Scanning folder: ${srcFolder}`);

    const allFiles = await getAllFiles(srcFolder);
    core.info(`Found ${allFiles.length} files.`);

    const todos = await findTodosInFiles(allFiles);

    if (todos.length > 0) {
      todos.forEach(({ file, todo, line }) => {
        core.warning(`TODO found in ${file} at line ${line}: ${todo}`);
      });

      if (strictMode) {
        core.setFailed(`Found ${todos.length} TODO comments in the codebase.`);
      } else {
        core.info(`Found ${todos.length} TODO comments in the codebase.`);
      }
    } else {
      core.info('No TODO comments found!');
    }
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
```

This script:

- Searches a specified directory (default `./src`) for files that contain `TODO` comments.
- It scans the files and checks for lines that contain `TODO` comments (matching the pattern `// TODO: <message>`).
- It outputs the results, warning you about each TODO found, and in strict mode, it will fail the workflow if any TODO comments are found.

---

### **Step 4: Install Dependencies**

You need to install the required Node.js modules to interact with GitHub Actions.

1. In the `.github/actions/todo-checker-javascript-action` directory, run the following commands:

   ```bash
   npm init -y
   npm install @actions/core
   ```

2. Additionally, install `ncc` to bundle the code for the GitHub Action:

   ```bash
   npm install -g @vercel/ncc
   ```

---

### **Step 5: Bundle the Action**

To bundle your JavaScript code into a single file for GitHub Actions, run:

```bash
ncc build index.js -o dist
```

This command will bundle the `index.js` file into the `dist/index.js` file, which will be used in the `action.yml`.

---

### **Step 6: Commit the Action Files**

Once you've created the action files and bundled the JavaScript, commit them to your repository:

```bash
git add .github/actions/todo-checker-javascript-action/*
git commit -m "Create TODO checker action"
git push origin main
```

---

### **Step 7: Create the Workflow to Run the Action**

1. In the root of your repository, create the `.github/workflows` directory if it doesn't already exist.
2. Create a new file called `custom-javascript-action-todo-checker.yml` in `.github/workflows` with the following content:

```yaml
name: To-Do Checker Workflow

on:
  push:
    paths:
      - '.github/actions/javascript-action-todo-checker/**'
  workflow_dispatch:

jobs:
  todo-checker:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Run TODO Checker Action
        uses: ./github/actions/javascript-action-todo-checker
        with:
          src-folder: './src'

      - name: Display Completed Tasks
        run: echo "Completed TODO check. See the results above."
```

This workflow:

- Runs whenever there is a push to the action's directory or when manually triggered.
- Uses the custom action to scan a specified folder (default is `./src`) for TODO comments.
- Displays the results in the workflow output.

---

### **Step 8: Run the Workflow**

1. Push the workflow to your repository:

   ```bash
   git add .github/workflows/todo-checker.yml
   git commit -m "Add workflow to run TODO checker action"
   git push origin main
   ```

2. Go to the **Actions** tab in your GitHub repository to see the workflow run.

3. Check the output of the "Run TODO Checker Action" step to verify that the TODO comments were detected.

---

### **Step 9: Modify and Experiment**

Try modifying the `src-folder` input, or experiment with adding `TODO` comments in various parts of your code. You can also enhance the action by adding more features such as:

- Specifying multiple folders to scan.
- Changing the `strict` mode behavior to control the workflow failure behavior.

---

### **Conclusion:**

In this lab, you have:

- Created a custom GitHub Action using JavaScript to scan for `TODO` comments in your codebase.
- Defined inputs and outputs for the action.
- Created a workflow to use the custom action and display the results.

You can now use this action to enforce clean code practices by tracking `TODO` comments and ensuring that they are addressed.
