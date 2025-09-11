#!/usr/bin/env bash
set -e

# Simple wait-for-postgres (if DATABASE_URL is used)
if [ -n "${DATABASE_URL}" ]; then
  echo "DATABASE_URL detected, attempting simple wait..."
  # Parse host and port from DATABASE_URL if possible, fall back to 5432
  DB_HOST=$(echo "$DATABASE_URL" | sed -n 's#.*@\([A-Za-z0-9._-]*\):\([0-9]*\)/.*#\1#p')
  DB_PORT=$(echo "$DATABASE_URL" | sed -n 's#.*@\([A-Za-z0-9._-]*\):\([0-9]*\)/.*#\2#p')
  DB_HOST=${DB_HOST:-}
  DB_PORT=${DB_PORT:-5432}
  if [ -n "$DB_HOST" ]; then
    echo "Waiting for DB at $DB_HOST:$DB_PORT ..."
    for i in $(seq 1 30); do
      if nc -z "$DB_HOST" "$DB_PORT" >/dev/null 2>&1; then
        echo "DB reachable"
        break
      fi
      echo "Waiting... ($i)"
      sleep 2
    done
  fi
fi

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting Gunicorn..."
exec gunicorn yzer_membership.wsgi:application --workers 3 --bind 0.0.0.0:${PORT}
