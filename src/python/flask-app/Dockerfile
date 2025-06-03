# Use the official Python image as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt if it exists
COPY requirements.txt ./

# Install dependencies if requirements.txt is present
RUN if [ -f requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Set the default command to run the Flask app
CMD ["python", "app.py"]
