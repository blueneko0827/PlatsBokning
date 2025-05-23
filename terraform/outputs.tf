output "ec2_public_ip" {
  value = aws_instance.rails_server.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.rails_db.address
}
