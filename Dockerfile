# Use a small Python image
FROM python:3.10-slim

# Safer, cleaner defaults
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

# Workdir
WORKDIR /app

# Install Langflow (and any extras you add to requirements.txt)
COPY requirements.txt .
RUN pip install --upgrade pip setuptools wheel \
 && pip install -r requirements.txt

# IMPORTANT: Render injects $PORT at runtime.
# We don't EXPOSE or hardcode the port here.
CMD ["bash", "-lc", "langflow run --host 0.0.0.0 --port $PORT"]
