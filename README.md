# README

System for booking desks in a shared office space with AWS deployment.

Things you may want to cover:

* Ruby version: 3.1.2

* System dependencies: Rails 7.0.4

* Configuration

For Unix-Like <Ubuntu> install postgres libs for dev:

sudo apt-get install libpq-dev


* Database creation: PostgreSQL Development with Docker
* Database initialization:
Create image with: `docker build -t postgres_plats .Postgres.Dockerfile`
Run container with: `docker run -d --name appdb -p 5432:5432 -v appdb_data:/var/lib/postgresql/data postgres_plats`


* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
With terraform
´´´
terraform init
terraform validate
terraform apply -var-file="secrets.tfvars"
´´´

* ...


## Deployment with Azure Serives

Create ECR repository for docker image
´´´
cd terraform/repository
terraform init
terraform apply
terraform output ecr_repository_url
´´´

Build image and publish to ECR repository
´´´
docker build -t platsbokning:latest .
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin [YOUR_ACCOUNT_ID].dkr.ecr.eu-west-1.amazonaws.com
docker tag platsbokning:latest [ACCOUNT_ID].dkr.ecr.eu-west-1.amazonaws.com/platsbokning:latest
docker push [ACCOUNT_ID].dkr.ecr.eu-west-1.amazonaws.com/platsbokning:latest
´´´

Update Image - Release deploy
´´´
aws ecr describe-images --repository-name platsbokning
docker build -t platsbokning:latest .
docker tag platsbokning:latest [ACCOUNT_ID].dkr.ecr.[REGION_ID].amazonaws.com/platsbokning:latest
docker push [ACCOUNT_ID].dkr.ecr.[REGION_ID].amazonaws.com/platsbokning:latest
aws ecs update-service --cluster platsbokning-cluster --service platsbokning-service --force-new-deployment
´´´

Get ECR repo URL
´´´
ECR_REPO=$(terraform output -raw ecr_repository_url)
echo $ECR_REPO
´´´

Clean Resources
´´´
sh clean.sh
´´´

Redeploy
sh redeploy.sh
