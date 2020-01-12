#!/bin/bash
cd aws-terraform; terraform apply -var 'key_name=terraform' -var 'public_key_path=/var/lib/jenkins/.ssh/id_rsa.pub'
exit 0 