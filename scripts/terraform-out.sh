#!/bin/bash

  cd aws-terraform; terraform output --json > test/verify/files/terraform.json
  exit 0 