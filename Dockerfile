# Use lightweight Python
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Prevents Python from writing .pyc files
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy project files (if any)
COPY . .

# Run Langflow
CMD ["langflow", "run", "--host", "0.0.0.0", "--port", "7860"]
