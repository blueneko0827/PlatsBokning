aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $(terraform output -raw ecr_repo_url)
docker build -t rails-app .
docker tag rails-app:latest $(terraform output -raw ecr_repo_url):latest
docker push $(terraform output -raw ecr_repo_url):latest