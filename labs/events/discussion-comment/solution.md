## Solution: Event - Discussion Comment

```yaml
name: Event - Discussion Comment

   on:
     discussion_comment:
       types: [created]

   permissions:
     contents: read
     discussions: read

   jobs:
     check-comment:
       runs-on: ubuntu-latest
       steps:
         - name: Log comment
           run: echo "Comment: ${{ github.event.comment.body }}"

         - name: Check for keyword in comment
           if: contains(github.event.comment.body, 'urgent')
           run: echo "This comment is marked as URGENT!"

         - name: Check for unauthorized keyword
           if: contains(github.event.comment.body, 'shutdown')
           run: |
             echo "::warning::Detected sensitive keyword 'shutdown'. Manual review recommended."
```
