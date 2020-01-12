#!/bin/bash 
cd aws-terraform;
export AWS_REGION=us-east-1
inspec exec test/verify -t aws:// --chef-license accept-silent

