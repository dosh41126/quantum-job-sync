# Base Python image
FROM python:3.11-slim

# Metadata
LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="Quantum-Aware Job Application Bot using OpenAI and PennyLane"

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    CACHE_DIR=/app/job_applicator_v6_data \
    PIP_NO_CACHE_DIR=1

# Create working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libffi-dev \
    libssl-dev \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements directly
COPY requirements.txt .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy source code
COPY . .

# Create cache directory
RUN mkdir -p ${CACHE_DIR}

# Optional: Use a non-root user for safety
RUN useradd -m jobuser
USER jobuser

# Entry point (can be overridden)
CMD ["python", "main.py"]
