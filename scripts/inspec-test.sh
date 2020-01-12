#!/bin/bash 
cd aws-terraform;
export AWS_REGION=eu-west-2
inspec exec test/verify -t aws:// --chef-license accept-silent

