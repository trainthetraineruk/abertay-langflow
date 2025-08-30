# Use a small Python image
FROM python:3.10-slim

# Ensure bash so we can expand $PORT in CMD
SHELL ["/bin/bash", "-lc"]

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# System deps needed by some py wheels (kept minimal)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy only reqs first to leverage Docker layer cache
COPY requirements.txt /app/requirements.txt

# Upgrade pip and install deps
RUN python -m pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# Expose (Render injects $PORT; we still expose a typical dev port)
EXPOSE 7860

# Start Langflow binding to the Render port
# SHELL above lets us expand ${PORT}; default to 7860 locally
CMD python -m langflow run --host 0.0.0.0 --port ${PORT:-7860}
