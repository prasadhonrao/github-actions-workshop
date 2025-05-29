<p align="center">
  <img src="./images/logo.png" alt="GitHub Actions Workshop Logo" height="128">
</p>

<!-- <h1 align="center">GitHub Actions Workshop</h1> -->

<p align="center">⭐ If you like this repo, star it on GitHub — it helps a lot! ⭐</p>

<p align="center">
  <a href="#overview">Overview</a> • 
  <a href="#prerequisites">Prerequisites</a> • 
  <a href="#objectives">Objectives</a> • 
  <a href="#labs">Labs</a> • 
  <a href="#resources">Resources</a> • 
  <a href="#license">License</a>
</p>

---

## Overview

Welcome to the **GitHub Actions Workshop**! This interactive workshop is designed to help you learn, practice, and master GitHub Actions—GitHub's powerful automation platform for building, testing, and deploying code.

Throughout this workshop, you'll gain hands-on experience in:

- Automating workflows to streamline your development process.
- Running tests to ensure code quality and reliability.
- Deploying applications efficiently to various environments.
- Leveraging GitHub Actions to integrate with third-party services and tools.

The workshop is structured around a series of labs, exercises, and real-world example workflows. Each lab is crafted to incrementally build your knowledge and skills, making it accessible whether you're a beginner exploring automation for the first time or an experienced developer looking to optimize and scale your CI/CD pipelines.

By the end of this workshop, you'll have the tools and confidence to harness the full potential of GitHub Actions, enabling you to automate complex processes, improve productivity, and accelerate software delivery.

---

## Objectives

By the end of this workshop, you will learn how to:

1. **Understand GitHub Actions Fundamentals**:

   - Grasp the basics of GitHub Actions and its architecture.
   - Learn the YAML syntax used to define workflows.
   - Understand workflow syntax and how to write workflows using IntelliSense.

2. **Create and Customize Workflows**:

   - Set up GitHub Actions workflows from scratch.
   - Trigger workflows using various events such as `push`, `pull_request`, and `workflow_dispatch`.
   - Customize workflows with job and step attributes.

3. **Use Contexts, Expressions, and Commands**:

   - Leverage contexts and expressions to create dynamic workflows.
   - Learn GitHub Actions workflow commands to pass data between steps and manage workflow behavior.

4. **Optimize Runner Options**:

   - Understand different hosting options for runners, including GitHub-hosted and self-hosted runners.
   - Configure and optimize runners for better performance and cost efficiency.

5. **Integrate Advanced Features**:

   - Use secrets and environment variables securely in workflows.
   - Employ workflow templates and reusable workflows to standardize automation across repositories.
   - Integrate GitHub Actions with external tools and services, such as Slack, AWS, and Jira.

6. **Create Custom Actions**:

   - Develop custom JavaScript and Docker actions for specific needs.
   - Publish and maintain custom actions on the GitHub Marketplace.

7. **Implement and Manage CI/CD Pipelines**:

   - Build robust CI/CD pipelines for various technologies, including:
     - ASP.NET Core Web Apps and Web APIs.
     - Frontend frameworks like React.
     - Python applications with virtual environments and dependency management.
   - Automate the packaging and publishing of artifacts to GitHub Releases, NuGet, or PyPI.
   - Automate deployment workflows to cloud providers, such as Azure, AWS, or Google Cloud.

8. **Debug and Troubleshoot**:

   - Debug workflows using logging and the debug feature.
   - Troubleshoot common issues like permission errors, job failures, and event mismatches.

9. **Follow Best Practices**:

   - Adopt best practices for workflow design, security, and performance.
   - Use linting tools and code reviews to maintain high-quality workflows.

10. **Leverage Advanced Topics** _(Optional for Advanced Users)_:
    - Use matrix builds to test across multiple configurations.
    - Implement caching for dependencies and workflows.
    - Explore composite actions to combine multiple steps into reusable units.
    - Analyze and optimize workflow performance with metrics and analytics.

---

## Prerequisites

Before you start the workshop, ensure you meet the following requirements:

### Hardware and Connectivity

- **Device**: A laptop or desktop computer running **Windows**, **macOS**, or **Linux**.
- **Internet Access**: A stable internet connection is necessary to interact with GitHub and other cloud-based services during the workshop.

### GitHub Setup

- **GitHub Account**: A personal GitHub account is required to create repositories and workflows. If you don’t already have one, [create a GitHub account for free](http://github.com).

### Development Environment

- **Code Editor**: Use any code editor of your choice. The recommended editor is [Visual Studio Code](https://code.visualstudio.com/) for its GitHub integrations and YAML IntelliSense support.
- **Git Installed**: Ensure Git is installed and configured on your system. You can download Git from the [official website](https://git-scm.com/).

### Knowledge Prerequisites

- **Git and GitHub Basics**:
  - Familiarity with concepts such as repositories, commits, branches, and pull requests.
  - If you’re new to Git and GitHub, start with the [Getting Started with GitHub Guide](https://guides.github.com/activities/hello-world/).

### Accounts and Tools

- **Cloud Service Accounts** _(Optional, based on workshop goals)_:
  - Accounts on services like **Azure**, **AWS**, or **Google Cloud Platform** may be needed if the workshop includes deployment exercises.
- **Docker Hub Account** _(Optional)_:
  - Required if you plan to build and push custom Docker actions to a container registry.

### Software Tools

- **GitHub CLI** _(Optional)_:
  - Install the [GitHub CLI](https://cli.github.com/) for certain exercises involving automation with the CLI.
- **Docker** _(Optional)_:
  - Install Docker if working on custom Docker-based actions. Refer to the [Docker installation guide](https://docs.docker.com/get-docker/).
- **Language Runtimes** _(Optional)_:
  - Depending on the examples or pipelines used, install relevant runtimes like **Node.js**, **Python**, or **.NET SDK**.

### Permissions and Access

- **Repository Access**:
  - You will need permissions to create repositories and manage workflows in your GitHub account or organization.
- **Secrets Management**:
  - Access to create and manage repository or organization secrets for use in workflows.

---

## Labs

The core of this workshop is built around a set of labs that walk you through the process of automating your software development workflows using GitHub Actions.

To get started, navigate to the workshop [labs](./labs.md) page where you'll find all the exercises, instructions, and challenges designed to help you understand and implement GitHub Actions step by step. Feel free to explore the labs and start working through them at your own pace!

---

## Resources

### Official GitHub Actions Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions): The official guide to understanding and using GitHub Actions.
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions): Explore a vast library of pre-built actions to use in your workflows.
- [GitHub Actions Community Forum](https://github.community/c/github-actions/42): A place to ask questions, share ideas, and discuss GitHub Actions with the community.

### Learning and Tutorials

- [Getting Started with GitHub Actions](https://docs.github.com/en/actions/quickstart): A beginner-friendly tutorial to set up your first workflow.
- [GitHub Actions Examples](https://github.com/actions/starter-workflows): A collection of starter workflows and use-case examples.
- [GitHub Learning Lab](https://lab.github.com/githubtraining/ci-cd-with-github-actions): Interactive courses to learn CI/CD with GitHub Actions.

### Guides

- [GitHub Actions Guide](https://docs.github.com/en/actions/guides): A series of guides on various topics related to GitHub Actions.
- [Reusable Workflows Documentation](https://docs.github.com/en/actions/using-workflows/reusing-workflows): Understand how to create and use reusable workflows to streamline automation.

### Community Curated Resources

- [Awesome Actions](https://github.com/sdras/awesome-actions): A curated list of awesome actions and workflow examples.
- [Actions by GitHub](https://github.com/actions): Explore open-source actions maintained by GitHub.

### Debugging and Optimization

- [GitHub Actions Troubleshooting Guide](https://docs.github.com/en/actions/monitoring-and-troubleshooting-workflows/troubleshooting-workflows): Tips for debugging failed workflows.
- [Caching Dependencies](https://docs.github.com/en/actions/using-workflows/caching-dependencies-to-speed-up-workflows): Learn how to cache dependencies to optimize workflow execution time.

### Security and Compliance

- [Securing GitHub Actions](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions): Best practices for securing your workflows and actions.
- [Managing Secrets in GitHub Actions](https://docs.github.com/en/actions/security-guides/encrypted-secrets): Guidelines for securely managing sensitive information.

### Additional Tools and Integrations

- [GitHub CLI Documentation](https://cli.github.com/manual): Automate and manage workflows directly from the command line.
- [Docker Hub](https://hub.docker.com/): Explore and share Docker images for use in custom Docker actions.
- [Using Actions with Azure](https://learn.microsoft.com/en-us/azure/devops/pipelines/repos/github-actions): A guide to integrating GitHub Actions with Azure services.
- [Using Actions with AWS](https://docs.aws.amazon.com/codepipeline/latest/userguide/github-actions.html): Learn how to integrate GitHub Actions with AWS.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
