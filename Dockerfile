# Base Image: Python 3.10 Slim
FROM python:3.10-slim

# Create Directory
RUN mkdir -p /opt/dagster/dagster_home /opt/dagster/app

# Set work directory
WORKDIR /opt/dagster/app

# COPY Dependencies
COPY . . 

# Install Requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Install Additional Dependencies for Postgres
RUN apt-get update && apt-get install -y \
    libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for Dagster
ENV DAGSTER_HOME = /opt/dagster/app/

# Create directories for storing logs and data
RUN mkdir -p /opt/dagster/compute_logs/ /opt/dagster/storage/

# Expose port 3000 (Default Dagster Port Opening)
EXPOSE 3000

CMD ["dagster-webserver", "-h", "0.0.0.0"]






