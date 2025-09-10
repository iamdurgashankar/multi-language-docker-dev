# Multi-stage build for production
FROM python:3.11-slim as base

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    gcc \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better caching
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Development stage
FROM base as development
ENV FLASK_ENV=development
ENV FLASK_DEBUG=1
COPY . .
EXPOSE 5000
CMD ["python", "app.py"]

# Production stage
FROM base as production
ENV FLASK_ENV=production
ENV FLASK_DEBUG=0
COPY . .
RUN useradd --create-home --shell /bin/bash app
USER app
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]