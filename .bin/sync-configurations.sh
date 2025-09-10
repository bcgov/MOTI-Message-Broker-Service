#!/usr/bin/env bash

# curl -u <username>:<password> https://<rabbitmq-url>/api/definitions > rabbitmq-defs.json

# Input and output file paths
INPUT_FILE="rabbitmq-defs.json"
OUTPUT_FILE="rabbitmq-defs-filtered.json"

# Use jq to select and filter fields
jq '{
  users: (.users | map(select(.name != "admin"))),
  vhosts: .vhosts,
  permissions: .permissions,
  topic_permissions: .topic_permissions,
  policies: .policies,
  queues: .queues,
  exchanges: .exchanges,
  bindings: .bindings
}' "$INPUT_FILE" > "$OUTPUT_FILE"

echo "Filtered definitions saved to $OUTPUT_FILE"

# curl -u <username>:<password> -H "Content-Type: application/json" -X POST --data-binary @rabbitmq-defs-filtered.json https://<new-rabbitmq-url>/api/definitions
