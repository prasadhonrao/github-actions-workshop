## Lab: Create Workflow Template

## Introduction

Workflow templates allow everyone in your organization who has permission to create workflows to do so more quickly and easily. When you create a new workflow, you can choose a workflow template and some or all of the work of writing the workflow will be done for you. You can use workflow templates as a starting place to build your custom workflow or use them as-is. This not only saves time, it promotes consistency and best practice across your organization.

## Instructions

<!-- Write steps from creating an organization till creating workflow template in it -->

1. Goto GitHub.com and login to your account.

2. Navigate to `Your Profile` -> `Your Organizations` -> `New Organization`

3. Select appropriate plan for your organization and click on `Continue`

4. Fill in the details and complete the setup.

5. Create a new public repository named `.github` in your organization.

6. Create a directory named `workflow-templates`

7. Create your new workflow file `octo-organization-ci.yml` inside the `workflow-templates` directory and add the following content:

   ```yaml
   name: Octo Organization CI

   on:
     push:
       branches: [$default-branch]
     pull_request:
       branches: [$default-branch]

   jobs:
     build:
       runs-on: ubuntu-latest

       steps:
         - uses: actions/checkout@v4

         - name: Run a one-line script
           run: echo Hello from Octo Organization
   ```

8. Create a metadata file inside the `workflow-templates` directory. The metadata file must have the same name as the workflow file, but instead of the `.yml` extension, it must be appended with .properties.json. For example, this file named `octo-organization-ci.properties.json` contains the metadata for a workflow file named `octo-organization-ci.yml`:

   ```json
   {
     "name": "Octo Organization CI",
     "description": "This workflow is used to build and test the Octo Organization project.",
     "icon": "gear",
     "categories": ["Build", "Test"]
   }
   ```

9. Commit the changes to the repository.

10. Navigate to the `Actions` tab of the repository.

11. Here you will find the workflow template that you just created.

12. Click on the `Configure` button to create a new workflow using the template.

13. Fill in the details and click on `Start commit`.

14. Your new workflow will be created and will start running.

## Summary

In this lab, you learned how to create workflow templates in your organization. You can use these templates to quickly create new workflows that are consistent and follow best practices.
