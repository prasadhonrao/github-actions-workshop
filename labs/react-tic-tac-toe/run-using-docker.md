## Run React Tic-Tac-Toe Using Docker

## Objective

In this lab, you will learn how to run a React Tic-Tac-Toe game in a container using a pre-built Docker image. By the end of this lab, you will have the game running locally and accessible through your web browser.

> Duration: 15-30 minutes

---

## Prerequisites

1. **Docker Installed**: Ensure Docker is installed on your system. If not, download and install Docker from [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
2. **Docker Image**: The image `prasadhonrao/react-tic-tac-toe` should be accessible from Docker Hub.

---

## Instructions

### Step 1: Pull the Docker Image

1. Open a terminal on your local machine.
2. Pull the Docker image from Docker Hub by running the following command:

   ```bash
   docker pull prasadhonrao/react-tic-tac-toe
   ```

   > This will download the pre-built Docker image to your local machine.

---

### Step 2: Run the Docker Container

1. Start a container using the downloaded Docker image by running:

   ```bash
   docker run -d -p 8080:80 --name react-tic-tac-toe prasadhonrao/react-tic-tac-toe
   ```

   **Explanation of Parameters**:

   - `-d`: Runs the container in detached mode.
   - `-p 8080:80`: Maps port 80 in the container to port 8080 on your local machine.
   - `--name react-tic-tac-toe`: Assigns the name `react-tic-tac-toe` to the container.
   - `prasadhonrao/react-tic-tac-toe`: Specifies the Docker image to use.

2. Verify that the container is running by executing:

   ```bash
   docker ps
   ```

   You should see an entry for the `react-tic-tac-toe` container.

---

### Step 3: Access the Application

1. Open your web browser.
2. Navigate to [http://localhost:8080](http://localhost:8080).
3. You should see the React Tic-Tac-Toe game interface. You can now play the game!

---

### Step 4: Stop and Remove the Container (Optional)

If you want to stop the container, run:

```bash
docker stop react-tic-tac-toe
```

To remove the container after stopping it, run:

```bash
docker rm react-tic-tac-toe
```

---

## Summary

In this lab, you successfully:

1. Pulled the Docker image for the React Tic-Tac-Toe game.
2. Ran the image in a container and accessed the game locally.
3. Learned basic Docker commands to manage containers.

---

## Additional Notes

- To use a different port, modify the `-p` parameter in the `docker run` command. For example, to use port 3000:

  ```bash
  docker run -d -p 3000:80 --name react-tic-tac-toe prasadhonrao/react-tic-tac-toe
  ```

  Access the game at [http://localhost:3000](http://localhost:3000).

- To explore logs from the container, run:

  ```bash
  docker logs react-tic-tac-toe
  ```
