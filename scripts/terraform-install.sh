#!/bin/bash

which terraform

# Get the status
status=$?

#nlookup status
if [ $status -eq 0 ]; then
  echo "terraform  found"
  terraform -v; ls -al ; terraform init
  exit 0 
  else 
  wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
  unzip terraform_0.12.19_linux_amd64.zip
  sudo mv terraform /bin/
  terraform -v
  rm -rf terraform_0.12.19_linux_amd64.zip
  exit  $status
fi


