## Solution: Event - Discussion

```yaml
name: Event - Discussion

on:
  discussion:
    types: [created, edited, deleted]

jobs:
  handle-discussion:
    runs-on: ubuntu-latest

    steps:
      - name: Print full event payload
        run: |
          echo "Full event payload:"
          echo "${{ toJSON(github.event) }}"

      - name: Print discussion metadata
        run: |
          echo "🗣️ Event Type: ${{ github.event.action }}"
          echo "📌 Title: ${{ github.event.discussion.title }}"
          echo "✍️ Author: ${{ github.event.discussion.user.login }}"
          echo "📝 Category: ${{ github.event.discussion.category.name }}"
          echo "💬 Body: ${{ github.event.discussion.body }}"

      - name: On Create
        if: github.event.action == 'created'
        run: echo "🎉 A new discussion was created!"

      - name: On Edit
        if: github.event.action == 'edited'
        run: echo "✏️ A discussion was edited!"

      - name: On Delete
        if: github.event.action == 'deleted'
        run: echo "🗑️ A discussion was deleted!"
```
