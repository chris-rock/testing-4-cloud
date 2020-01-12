#!/bin/bash

which terraform

# Get the status
status=$?

#nlookup status
if [ $status -eq 0 ]; then
  echo "terraform  found"
  export ${AWS_ACCESS_KEY}
  export ${AWS_SECRET_ACCESS_KEY}
  echo ${AWS_ACCESS_KEY}
  sudo ls -al /home/ec2-user/*
  cd aws-terraform; terraform plan -var 'key_name=terraform' -var 'public_key_path=/home/ec2-user/.ssh/id_rsa.pub'
  exit 0 
  else 
  wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
  unzip terraform_0.12.19_linux_amd64.zip
  sudo mv terraform /bin/
  terraform -v
  rm -rf terraform_0.12.19_linux_amd64.zip
  cd aws-terraform; terraform init
  exit  $status
fi