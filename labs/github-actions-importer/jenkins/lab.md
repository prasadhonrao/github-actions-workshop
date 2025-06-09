## 🧪 Lab: Migrate Jenkins Workflow to GitHub Actions

> **Estimated Time**: 30–45 minutes

---

## ✅ Step 1: Install Jenkins Locally

### 🔧 Prerequisites:

- Java 11 or 17 (Jenkins requires Java)
- Admin rights on your PC

### 💻 Option A: Use Docker (Recommended)

```bash
docker run -p 8080:8080 -p 50000:50000 jenkins/jenkins:lts
```

- Access Jenkins at: `http://localhost:8080`
- Retrieve the initial admin password with:

```bash
docker exec -it <container_id_or_name> cat /var/jenkins_home/secrets/initialAdminPassword
```

---

### 💻 Option B: Install Natively (If you prefer)

1. Download Jenkins from [https://www.jenkins.io/download/](https://www.jenkins.io/download/)
2. Install using the installer (Windows/macOS/Linux)
3. Access via `http://localhost:8080`
4. Unlock using the initial password from:

   ```
   C:\Program Files\Jenkins\secrets\initialAdminPassword
   ```

---

## ✅ Step 2: Create a Sample Jenkins Pipeline

### 🔨 Create a New Pipeline Job

1. Go to `http://localhost:8080`
2. Click **“New Item”**
3. Name it: `sample-pipeline`
4. Choose **Pipeline** > Click **OK**

### 📜 Define Jenkinsfile Script

Paste this sample script in the **Pipeline script** section:

```groovy
pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo 'Building the project...'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the app...'
            }
        }
    }
}
```

5. Click **Save**
6. Run the pipeline to verify it works

---

## ✅ Step 3: Install GitHub Actions Importer CLI

```bash
npm install -g @github/actions-importer
```

> If you don't have `npm`, install [Node.js](https://nodejs.org/) first.

---

## ✅ Step 4: Authenticate GitHub CLI

```bash
gh auth login
```

> Make sure to authenticate with a token that has:
>
> - `repo`
> - `workflow`

---

## ✅ Step 5: Use GitHub Actions Importer

Run the following command to inspect the Jenkins job:

```bash
actions-importer analyze jenkins \
  --jenkins-url http://localhost:8080 \
  --jenkins-user admin \
  --jenkins-token <API-TOKEN> \
  --project sample-pipeline
```

> 💡 You can get the **API token** from your Jenkins account settings.

Then to generate the equivalent GitHub Actions workflow:

```bash
actions-importer generate jenkins \
  --jenkins-url http://localhost:8080 \
  --jenkins-user admin \
  --jenkins-token <API-TOKEN> \
  --project sample-pipeline \
  --output-dir ./generated-workflows
```

You'll see a `.yml` file inside `./generated-workflows`.

---

## ✅ Step 6: Push the Workflow to GitHub

1. Copy the `.yml` file into your repo under `.github/workflows/`
2. Commit and push it:

```bash
git add .github/workflows/sample.yml
git commit -m "Migrate Jenkins to GitHub Actions"
git push origin main
```

3. Go to **Actions tab** in your repo to verify the workflow is listed and runs.

---

## ✅ Summary

In this demo, you:

- Installed Jenkins locally (via Docker or natively)
- Created a basic Pipeline job
- Used GitHub Actions Importer CLI to analyze and convert it
- Pushed the resulting workflow to GitHub and tested it

