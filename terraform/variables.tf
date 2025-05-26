variable "region" {
  default = "eu-north-1"
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "db_name" {
  default = "platsbokning"
}

variable "db_username" {
  default = "platsbokning"
}

variable "db_password" {
  default = "*SametSis1!"
}
