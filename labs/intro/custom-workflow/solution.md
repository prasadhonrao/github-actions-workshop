## Solution: Custom Workflow

```yaml
name: Intro - Custom Workflow
on:
  workflow_dispatch:
  push:
    paths:
      - '.github/workflows/intro-custom-workflow.yml'
jobs:
  execute:
    runs-on: ubuntu-latest

    steps:
      - run: echo "🎉 The job was automatically triggered by a ${{ github.event_name }} event."
      - run: echo "🐧 This job is now running on a ${{ runner.os }} server hosted by GitHub!"
      - run: echo "🔎 The name of your branch is ${{ github.ref }} and your repository is ${{ github.repository }}."

      - name: Check Code
        uses: actions/checkout@v4

      - run: echo "💡 The ${{ github.repository }} repository has been cloned to the runner."
      - run: echo "🖥️ The workflow is now ready to test your code on the runner."

      - name: List Files In Directory
        run: |
          ls ${{ github.workspace }}

      - run: echo "🍏 This job's status is ${{ job.status }}."

      - name: Adding Markdown
        run: echo "### Hello world! :rocket:" >> "$GITHUB_STEP_SUMMARY"

        # This step uses GitHub's hello-world-javascript-action: https://github.com/actions/hello-world-javascript-action
      - name: Hello World
        uses: actions/hello-world-javascript-action@main
        with:
          who-to-greet: 'Mona the Octocat'
        id: hello

        # This step prints an output (time) from the previous step's action.
      - name: Echo Greeting's Time
        run: echo 'The time was ${{ steps.hello.outputs.time }}.'
```
