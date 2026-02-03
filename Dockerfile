FROM python:3.9-slim-bullseye

# Install system packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git wget pv jq python3-dev ffmpeg mediainfo neofetch \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m -u 10014 appuser

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Fix ownership
RUN chown -R appuser:appuser /app

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt flask

# Switch to non-root user (this silences CKV_DOCKER_3)
USER 10014

# Expose port
EXPOSE 10000

# Start services
CMD ["bash", "start.sh"]
