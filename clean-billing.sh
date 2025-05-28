#!/bin/bash
# Stoppa alla EC2-instanser
INSTANCES=$(aws ec2 describe-instances --region eu-north-1 --query 'Reservations[].Instances[].InstanceId' --output text)
aws ec2 terminate-instances --region eu-north-1 --instance-ids $INSTANCES

# Ta bort alla EBS-volymer
VOLUMES=$(aws ec2 describe-volumes --region eu-north-1 --query 'Volumes[?State!=`deleted`].VolumeId' --output text)
aws ec2 delete-volume --region eu-north-1 --volume-ids $VOLUMES

# Ta bort alla AMIs
IMAGES=$(aws ec2 describe-images --region eu-north-1 --owners self --query 'Images[].ImageId' --output text)
aws ec2 deregister-image --region eu-north-1 --image-ids $IMAGES

# Ta bort alla snapshots
SNAPSHOTS=$(aws ec2 describe-snapshots --region eu-north-1 --owner-ids self --query 'Snapshots[].SnapshotId' --output text)
aws ec2 delete-snapshot --region eu-north-1 --snapshot-ids $SNAPSHOTS

# Hämta alla VPC-ID:n
VPCS=$(aws ec2 describe-vpcs --region eu-north-1 --query 'Vpcs[].VpcId' --output text)

for VPC in $VPCS; do
  # Ta bort subnät
  SUBNETS=$(aws ec2 describe-subnets --region eu-north-1 --filters "Name=vpc-id,Values=$VPC" --query 'Subnets[].SubnetId' --output text)
  aws ec2 delete-subnet --region eu-north-1 --subnet-ids $SUBNETS

  # Ta bort route tables
  ROUTE_TABLES=$(aws ec2 describe-route-tables --region eu-north-1 --filters "Name=vpc-id,Values=$VPC" --query 'RouteTables[].RouteTableId' --output text)
  aws ec2 delete-route-table --region eu-north-1 --route-table-ids $ROUTE_TABLES

  # Ta bort internet gateways
  IGW=$(aws ec2 describe-internet-gateways --region eu-north-1 --filters "Name=attachment.vpc-id,Values=$VPC" --query 'InternetGateways[].InternetGatewayId' --output text)
  aws ec2 detach-internet-gateway --region eu-north-1 --internet-gateway-id $IGW --vpc-id $VPC
  aws ec2 delete-internet-gateway --region eu-north-1 --internet-gateway-id $IGW

  # Ta bort VPC
  aws ec2 delete-vpc --region eu-north-1 --vpc-id $VPC
done

# Stoppa och ta bort alla RDS-instanser
DB_INSTANCES=$(aws rds describe-db-instances --region eu-north-1 --query 'DBInstances[].DBInstanceIdentifier' --output text)
for DB in $DB_INSTANCES; do
  aws rds delete-db-instance --region eu-north-1 --db-instance-identifier $DB --skip-final-snapshot
done

# Lista och töm alla buckets
BUCKETS=$(aws s3api list-buckets --query 'Buckets[].Name' --output text)
for BUCKET in $BUCKETS; do
  aws s3 rb s3://$BUCKET --force --region eu-north-1
done