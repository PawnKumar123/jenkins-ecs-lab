#!/bin/bash

ACTION=$1

CLUSTER="jenkins-lab-cluster"
SERVICE="jenkins-lab-task-service-lwyxb6kz"
REGION="us-east-1"

if [ "$ACTION" = "START" ]; then

    echo "Starting ECS service..."

    aws ecs update-service \
        --cluster "$CLUSTER" \
        --service "$SERVICE" \
        --desired-count 1 \
        --region "$REGION"

elif [ "$ACTION" = "STOP" ]; then

    echo "Stopping ECS service..."

    aws ecs update-service \
        --cluster "$CLUSTER" \
        --service "$SERVICE" \
        --desired-count 0 \
        --region "$REGION"

else

    echo "Usage: $0 {START|STOP}"
    exit 1

fi
