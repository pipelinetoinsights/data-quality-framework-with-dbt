FROM python:3.9-slim

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    DBT_PROFILES_DIR=/usr/app/dbt

# Set working directory
WORKDIR /usr/app/dbt

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git \
        ssh-client \
        software-properties-common \
        make \
        build-essential \
        ca-certificates \
        libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install dbt
RUN pip install --no-cache-dir dbt-core dbt-duckdb

# Copy project files
COPY . /usr/app/dbt/

# Run dbt deps to install dependencies
RUN dbt deps

# The default command to run when starting the container
ENTRYPOINT ["dbt"]
CMD ["--help"] 