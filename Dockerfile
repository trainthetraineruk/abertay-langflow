# Use the prebuilt Langflow image (fast, reliable)
# Try Docker Hub first:
FROM langflowai/langflow:1.0.12
# If your environment prefers GHCR, use:
# FROM ghcr.io/langflow-ai/langflow:1.0.12

# Render will inject PORT; default to 7860 for local runs
ENV PORT=7860
EXPOSE 7860

# Start Langflow
CMD ["bash", "-lc", "langflow run --host 0.0.0.0 --port ${PORT}"]
