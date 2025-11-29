#!/bin/bash
set -e

CLUSTER="raa-default-cluster"
SERVICE="raa-default-api"

echo "📦 Deploying ECS service..."
terraform apply -target=aws_ecs_service.raa_default_api -auto-approve

echo "⏳ Waiting for service to start..."
sleep 15  # optional, ECS thodi der me start hota hai

echo "🔍 Fetching running task..."
TASK_ID=$(aws ecs list-tasks \
    --cluster $CLUSTER \
    --service-name $SERVICE \
    --query "taskArns[0]" \
    --output text)

if [ -z "$TASK_ID" ]; then
    echo "❌ No running task found. Exit."
    exit 1
fi

echo "🟢 Task ID: $TASK_ID"
echo "🔑 Executing command inside proxy container to fix permissions..."

aws ecs execute-command \
    --cluster $CLUSTER \
    --task $TASK_ID \
    --container proxy \
    --command "chown -R 101:101 /vol/web/media && chmod -R 755 /vol/web/media" \
    --interactive

echo "✅ Permissions fixed! Ready for demo."
