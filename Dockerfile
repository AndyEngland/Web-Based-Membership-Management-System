FROM python:3.11-slim

# Basic build deps
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    curl \
    && rm -rf /var/lib/apt/lists/*

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Build arg to force pip layer cache-bust when needed
ARG CACHEBUST=1

# Install Python deps
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy project
COPY . /app/



# Create persistent data directory for SQLite
RUN mkdir -p /data && chmod 777 /data

# Copy persistent database file if present
COPY data/db.sqlite3 /data/db.sqlite3

# Ensure entrypoint is executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose a port (Render uses $PORT at runtime)
EXPOSE 8000

ENV PORT 8000

ENTRYPOINT ["/app/entrypoint.sh"]
