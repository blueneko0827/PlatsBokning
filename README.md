# README

System for booking desks in a shared office space with Azure deployment.

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
