# Use a lightweight Python base image
FROM python:3.10-slim

# Keep Python from writing .pyc files & ensure stdout/stderr are unbuffered
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Work in /app
WORKDIR /app

# Install Python deps
COPY requirements.txt /app/requirements.txt
RUN python -m pip install --upgrade pip \
 && pip install -r requirements.txt

# Default port (Render will override PORT automatically)
ENV PORT=7860

# Expose the port for local runs (optional on Render)
EXPOSE 7860

# Run Langflow
CMD ["bash", "-lc", "langflow run --host 0.0.0.0 --port ${PORT}"]
