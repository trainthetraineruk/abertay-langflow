# Use Python 3.11 so Langflow installs
FROM python:3.11-slim

# Make Python behave nicely in containers
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# (Optional) build tools – some deps need them
RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Langflow (and uvicorn to run it)
RUN pip install --upgrade pip setuptools wheel \
    && pip install langflow==1.1.0 uvicorn

# Start Langflow via uvicorn and bind to Render's $PORT
CMD ["python", "-m", "uvicorn", "langflow.server:app", "--host", "0.0.0.0", "--port", "${PORT}", "--workers", "1", "--lifespan", "off"]
