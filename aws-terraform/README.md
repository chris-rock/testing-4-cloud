# Basic Two-Tier AWS Architecture

## Overview Terraform

This provides a template for running a simple two-tier architecture on Amazon Web services. The premise is that you have stateless app servers running behind an ELB serving traffic.

To simplify the example, this intentionally ignores deploying and getting your application onto the servers. However, you could do so either via
[provisioners](https://www.terraform.io/docs/provisioners/) and a configuration management tool, or by pre-baking configured AMIs with
[Packer](http://www.packer.io).

This example will also create a new EC2 Key Pair in the specified AWS Region. The key name and path to the public key must be specified via the  
terraform command vars.

After you run `terraform apply` on this configuration, it will automatically output the DNS address of the ELB. After your instance registers, this should respond with the default nginx web page.

To run, configure your AWS provider as described in 

https://www.terraform.io/docs/providers/aws/index.html

Run with a command like this:

```
terraform apply -var 'key_name={your_aws_key_name}' \
   -var 'public_key_path={location_of_your_key_in_your_local_machine}'
```

## Overview InSpec

This template provides an InSpec profile inside of the test/verify profile. InSpec ships with [built-in AWS resources](https://www.inspec.io/docs/reference/resources/#aws-resources). 

For some resources you need to information from terraform available. The best hand-over is the use of [terraform output](https://www.terraform.io/intro/getting-started/outputs.html) variables. Define every variable similar to:

```
output "vpc_id" {
  value = "${aws_vpc.default.id}"
}
```

Terraform allows the output of the variables as json file. InSpec is able to [load files from profiles](https://github.com/chef/inspec/issues/1396). 


```
terraform output --json > test/verify/files/terraform.json
```

Since InSpec is able to load files from the `files` directory directly, you can load the content via:

```
# load data from terraform output
content = inspec.profile.file("terraform.json")
params = JSON.parse(content)

# store vpc in variable
VPC_ID = params['vpc_id']['value']
```

Now, you can use the variable in various spaces

```
describe aws_vpc(vpc_id: VPC_ID) do
  its('cidr_block') { should cmp '10.0.0.0/16' }
end

describe aws_security_group(group_name: 'terraform_example') do
  it { should exist }
  its('group_name') { should eq 'terraform_example' }
  its('description') { should eq 'Used in the terraform' }
  its('vpc_id') { should eq VPC_ID }  
end
```


## Apply & Verify Cycle

To combine Terraform with InSpec just execute the following:

```
cd terraform
# download the required plugins
terraform init

# run terraform to apply the changes
terraform apply -var 'key_name=terraform' -var 'public_key_path=/Users/chris/.ssh/id_rsa.pub' -var 'private_key'path=/Users/chris/.ssh/id_rsa'

# make terraform variables available to inspec
terraform output -json > test/verify/files/terraform.json

# run the inspec profile to verify the setup
inspec exec test/verify -t aws://
```





