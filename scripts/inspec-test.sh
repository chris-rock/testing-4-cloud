#!/bin/bash 
cd aws-terraform
export AWS_REGION=eu-west-2
#pwd; inspec -v
inspec exec test/verify -t aws:// --chef-license accept-silent

