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

# Ensure entrypoint is executable
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expose a port (Render uses $PORT at runtime)
EXPOSE 8000

ENV PORT 8000

ENTRYPOINT ["/app/entrypoint.sh"]
