#!/bin/bash
cd ./terraform
terraform init

# Se vad som kommer att skapas (utan att göra något än)
terraform plan

# Applicera (skapa resurserna)
terraform apply -auto-approve