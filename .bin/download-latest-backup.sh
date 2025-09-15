#!/bin/bash
set -e
PVC_NAME="moti-message-broker-main-backup-pvc"
POD_NAME="pvc-inspect"
# Create a temporary JSON spec file
cat > overrides.json <<EOF
{
  "apiVersion": "v1",
  "spec": {
    "containers": [
      {
        "name": "$POD_NAME",
        "image": "busybox",
        "command": ["sleep", "3600"],
        "volumeMounts": [
          { "mountPath": "/backup", "name": "backup-pvc" }
        ]
      }
    ],
    "volumes": [
      {
        "name": "backup-pvc",
        "persistentVolumeClaim": { "claimName": "$PVC_NAME" }
      }
    ]
  }
}
EOF

kubectl delete pod "$POD_NAME" || true
# Start pod
kubectl run "$POD_NAME" --image=busybox --restart=Never --overrides="$(cat overrides.json)"
# Wait for it to be ready
kubectl wait --for=condition=Ready pod/"$POD_NAME" --timeout=30s
# Find latest backup file
LATEST=$(kubectl exec "$POD_NAME" -- sh -c 'ls -t /backup/rabbitmq-defs-*.json | head -n 1')
echo "Latest backup file: $LATEST"
# Copy to local
kubectl cp "$POD_NAME":"$LATEST" ./$(basename "$LATEST")
# Clean up
kubectl delete pod "$POD_NAME"
# Remove temp file
rm overrides.json
