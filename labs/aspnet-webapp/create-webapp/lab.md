## Lab: Create ASP.NET Web App

## Introduction

In this lab, you will create a .NET Core Web application using the command line. This app will be used for future labs.

> **Duration**: 10-20 minutes

---

## Instructions

### Step 1: Open Command Prompt and Create Project Directory

1. Open a command prompt or terminal window.
2. Create a new directory for the project by running the following command:

   ```bash
   mkdir WebApp
   ```

3. Navigate into the newly created directory:

   ```bash
   cd WebApp
   ```

---

### Step 2: Create a New .NET Core Web Application

1. In the command prompt, create a new .NET Core Web application by running:

   ```bash
   dotnet new webapp
   ```

   This will generate a basic ASP.NET Core Web application.

---

### Step 3: Run the Application

1. After the application is created, run it using the following command:

   ```bash
   dotnet run
   ```

2. The application will start and listen on a local port. You should see output indicating that the application is running.

---

### Step 4: Open the Application in a Browser

1. Open a web browser of your choice.
2. Navigate to the URL `https://localhost:5001` to view the application.

   > **Note**: The port number may vary. If you see a different port number in the output from `dotnet run`, use that number instead.

3. You should see the default .NET Core Web application in your browser.

---

### Step 5: Stop the Application

1. Once you're done viewing the application, stop it by pressing `Ctrl+C` in the command prompt. This will terminate the application.

---

### Step 6: Commit the Source Code to the Repository

1. Open your repository where you want to save the project.
2. Commit the source code of the application. For this lab, you can save the source code in a `src/dotnet` directory.

---

## Summary

In this lab, you successfully created a .NET Core Web application using the command line. You also ran the application locally in your browser. This application will be used in future labs.
