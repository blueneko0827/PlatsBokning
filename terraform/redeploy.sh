#!/bin/bash
# Initialize
terraform init

# Apply configuration
terraform apply -auto-approve

# Get ECR login and push image
aws ecr get-login-password --region eu-central-1 | docker login --username AWS --password-stdin YOUR_ACCOUNT_ID.dkr.ecr.YOUR_REGION.amazonaws.com
docker push YOUR_ECR_REPO_URL:latest