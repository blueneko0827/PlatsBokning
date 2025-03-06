#!/bin/bash

# Terraform cleanup
terraform destroy -auto-approve
rm -rf .terraform* terraform.tfstate*

# AWS resource cleanup
aws ecr batch-delete-image --repository-name platsbokning --image-ids imageTag=latest
aws ecr delete-repository --repository-name platsbokning --force
aws ecs delete-service --cluster platsbokning-cluster --service platsbokning-service --force
aws ecs delete-cluster --cluster platsbokning-cluster
aws rds delete-db-instance --db-instance-identifier platsbokning-db --skip-final-snapshot
aws elbv2 delete-load-balancer --load-balancer-arn $(aws elbv2 describe-load-balancers --query 'LoadBalancers[?LoadBalancerName==`platsbokning-alb`].LoadBalancerArn' --output text)
aws iam delete-role-policy --role-name platsbokning-ecs-execution-role --policy-name ecr-access-policy
aws iam delete-role --role-name platsbokning-ecs-execution-role
aws logs delete-log-group --log-group-name /ecs/platsbokning-task

echo "Cleanup complete!"