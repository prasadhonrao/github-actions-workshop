## Lab: Create and Use a Composite Action to Print a Message and Timestamp

## Introduction

In this lab, you will:

1. Create a **composite action** that prints a custom message and the current timestamp.
2. Use this composite action in a GitHub Actions workflow.
3. Understand the structure and components of a composite action.

---

## Step 1: Set Up the Composite Action

### Directory Structure

Ensure the following directory structure exists in your repository:

```plaintext
.github/
└── actions/
    └── print-message-and-time-composite-action/
        ├── action.yml
```

### Define the Composite Action (`action.yml`)

Create the `action.yml` file in the `.github/actions/print-message-and-time-composite-action` directory:

```yaml
name: "Print Message and Time"
description: "Prints a custom message and the current date/time"
author: "Your Name"
inputs:
  message:
    description: "The message to print"
    required: true
    default: "Hello, GitHub Actions!"
outputs:
  timestamp:
    description: "The current date and time"
runs:
  using: "composite"
  steps:
    # Step 1: Print the input message
    - name: Print the message
      run: echo "Message: ${{ inputs.message }}"

    # Step 2: Capture and output the current time
    - name: Get current timestamp
      id: current_time
      run: echo "timestamp=$(date)" >> $GITHUB_ENV

    # Step 3: Set the output from the timestamp
    - name: Set action output
      run: echo "timestamp=${{ env.timestamp }}"
      shell: bash
```

### Key Features of the Action:

- **Inputs**: Accepts a `message` with a default value of `"Hello, GitHub Actions!"`.
- **Outputs**: Returns the current timestamp (`timestamp`).
- **Environment Variables**: Uses `$GITHUB_ENV` to capture the timestamp for output.

---

## Step 2: Use the Composite Action in a Workflow

### Workflow File: `test-composite-action.yml`

Create a workflow file in `.github/workflows/test-composite-action.yml` to use the composite action:

```yaml
name: Test Composite Action

on:
  push:
    branches:
      - main
  workflow_dispatch:

jobs:
  test-composite-action:
    runs-on: ubuntu-latest
    steps:
      # Step 1: Checkout the repository
      - name: Checkout code
        uses: actions/checkout@v4

      # Step 2: Use the composite action
      - name: Run the custom composite action
        id: composite-action
        uses: ./github/actions/print-message-and-time-composite-action
        with:
          message: "Hello from Composite Action!"

      # Step 3: Access and display the output of the composite action
      - name: Print the timestamp
        run: echo "The timestamp is: ${{ steps.composite-action.outputs.timestamp }}"
```

---

## Step 3: Verify and Test

### Run the Workflow

1. Commit your changes and push them to the `main` branch.
2. Navigate to the **Actions** tab in your GitHub repository.
3. Run the workflow manually using the **workflow_dispatch** event or trigger it via a push event.

### Expected Output

- The composite action should print the custom message (`Hello from Composite Action!`).
- The timestamp will be captured and displayed in the logs.

---

## Step 4: Explore the Details

### Breakdown of Key Concepts

1. **Inputs**:
   - Define user-provided values (`message`) with a default option.
2. **Outputs**:
   - Use `$GITHUB_ENV` to capture and expose data across steps.
3. **Reusable Workflows**:
   - Composite actions simplify workflow reusability by encapsulating multiple steps.
4. **No Docker**:
   - Composite actions run directly on the runner, avoiding the need for Docker containers.

---

## Summary

In this lab, you:

- Created a composite action to print a message and timestamp.
- Used the action in a workflow and verified its functionality.
- Gained insight into key components like inputs, outputs, and environment variables.
