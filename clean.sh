#! /bin/bash

terraform destroy -auto-approve

# clean azure resources
az group delete --name booking-desk-rg --yes --no-wait
