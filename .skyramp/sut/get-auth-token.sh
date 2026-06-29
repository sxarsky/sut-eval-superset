#!/usr/bin/env bash
# Authenticates against the Superset REST API and prints a Bearer token to stdout.
# Admin credentials are seeded by docker-init.sh (username: admin / password: admin).
set -euo pipefail

SUPERSET_URL="${SUPERSET_URL:-http://localhost:8088}"
USERNAME="${SUPERSET_ADMIN_USERNAME:-admin}"
PASSWORD="${SUPERSET_ADMIN_PASSWORD:-admin}"

TOKEN=$(curl -sf -X POST "${SUPERSET_URL}/api/v1/security/login" \
  -H "Content-Type: application/json" \
  -d "{\"username\":\"${USERNAME}\",\"password\":\"${PASSWORD}\",\"provider\":\"db\",\"refresh\":true}" \
  | python3 -c "import sys, json; print(json.load(sys.stdin)['access_token'])")

echo "${TOKEN}"
