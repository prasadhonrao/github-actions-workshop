## Solution: Hello World Workflow

```yaml
name: Intro - Hello World Workflow

on: push
jobs:
  run:
    runs-on: ubuntu-latest
    steps:
      - name: Say Hello to the World
        run: echo "Hello, World!"
```
