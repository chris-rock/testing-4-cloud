#!/bin/bash 
cd aws-terraform;
inspec exec test/verify -t aws:// --chef-license accept-silent

