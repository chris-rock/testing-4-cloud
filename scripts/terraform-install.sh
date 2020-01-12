#!/bin/bash

wget https://releases.hashicorp.com/terraform/0.12.19/terraform_0.12.19_linux_amd64.zip
unzip terraform_0.12.19_linux_amd64.zip
mv terraform /bin/
sudo mv terraform /bin/
terraform -v
rm -rf terraform_0.12.19_linux_amd64.zip