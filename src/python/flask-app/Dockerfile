# Use the official Python Windows image as a parent image
FROM mcr.microsoft.com/windows/servercore:ltsc2022

# Set the working directory in the container
WORKDIR /app

# Copy requirements.txt if it exists
COPY requirements.txt ./

# Install dependencies if requirements.txt is present
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Set the default command to run the Flask app
CMD ["python", "app.py"]