#!/bin/bash
cd aws-terraform; 
eval `ssh-agent`; ssh-add /var/lib/jenkins/.ssh/id_rsa
terraform apply  -var 'key_name=terraform' -var 'public_key_path=/var/lib/jenkins/.ssh/id_rsa.pub' -auto-approve
exit 0 