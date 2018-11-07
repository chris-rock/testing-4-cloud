# Test-Driven Infrastructure for the Cloud

This repository demonstrates how to use InSpec helps you to verify your cloud setups in AWS, Azure or GCP. Recent additions in InSpec 3 also help you to extend InSpec to test your custom in-house applications.

I wrote a couple of articles about InSpec's ability to help you implement test-driven infrastructure with Terraform:

- [Google Cloud Platform support for InSpec](https://lollyrock.com/articles/inspec-cloud-gcp-setup/)
- [Getting started with InSpec for AWS. Testing for the cloud!](https://lollyrock.com/articles/inspec-cloud-aws-setup/)
- [InSpec for provisioning testing: Verify Terraform setups with InSpec](http://lollyrock.com/articles/inspec-terraform/)


This repository demonstrates how to use InSpec with provisioning tools. Recent additions to InSpec 2.0 allow us to verify not only machines, but also any infrastructure provisioned in AWS or Azure cloud. This repository is providing guidance on the use of provising tools in conjunction with InSpec.

- [Terraform for AWS](aws-terraform/README.md)
- [InSpec profile for GCP](gcp-example-profile/README.md)

## Examples


### Test AWS Terraform setups with InSpec

The following example will provision a two-tier terraform architecture on AWS. It assumes that you have AWS credentials properly configured.

```
cd aws-terraform
# run terraform
terraform init
terraform apply -var 'key_name=terraform' -var 'public_key_path=/Users/chris/.ssh/id_rsa.pub'

# use terraform variables with InSpec
terraform output --json > test/verify/files/terraform.json
inspec exec test/verify -t aws://
```

![InSpec Test Result](https://github.com/chris-rock/inspec-verify-provision/raw/master/docs/terraform_inspec.png "InSpec Test Result")


### Use InSpec to verify Google Cloud Platform setups


```
cd gcp-example-profile
# authenticate to gpc
gcloud auth application-default login

# check that inspec can connect to gpc
inspec detect -t gcp://

# run the profile
inspec exec . -t gcp:// --attrs attributes.yml
```

## License

|  |  |
| ------ | --- |
| **Author:** | Christoph Hartmann (<chris@lollyrock.com>) |
| **Author:** | Dominik Richter (<dominik.richter@gmail.com>) |
| **Copyright:** | Christoph Hartmann (<chris@lollyrock.com>) |
| **Copyright:** | Dominik Richter (<dominik.richter@gmail.com>) |
| **License:** | Mozilla Public License Version 2.0 |

The terraform aws example is based on their [two-tier example](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier) which is also MPL-2.0 licensed.

