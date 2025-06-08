## Solution: Create and Run a Custom Composite Action to Print a Message and the Current Time

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
