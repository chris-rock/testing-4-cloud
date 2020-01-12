#!/bin/bash

which inspec

# Get the status
status=$?

#terraform binary status
if [ $status -eq 0 ]; then
  echo "inspec  installed already, Skipping this stage"
  exit 0 
  else 
  wget https://packages.chef.io/files/stable/inspec/4.18.51/el/7/inspec-4.18.51-1.el7.x86_64.rpm
  sudo rpm -ivh inspec-4.18.51-1.el7.x86_64.rpm
  inspec -v
  exit  $status
fi


