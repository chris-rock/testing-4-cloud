# Inspec for provising testing

This repository demonstrates how to use InSpec with provising tools. Recent additions to InSpec 2.0 allow us to verify not only machines, but also any infrastructure provisioned in AWS or Azure cloud. This repository is providing guidance on the use of provising tools in conjunction with InSpec.

- [Terraform](terraform/README.md)
- AWS CloudFormation (planned)
- Azure Resource Manager Templates (planned)

## Getting Started

The following example will provision a two-tier terraform architecture on AWS. It assumes that you have AWS credentials properly configured.

```
cd terraform
terraform init
terraform apply -var 'key_name=terraform' -var 'public_key_path=/Users/chris/.ssh/id_rsa.pub'
terraform output --json > test/verify/files/terraform.json
inspec exec test/verify -t aws://
```

![InSpec Test Result](docs/terraform.png)

## License

|  |  |
| ------ | --- |
| **Author:** | Christoph Hartmann (<chris@lollyrock.com>) |
| **Author:** | Dominik Richter (<dominik.richter@gmail.com>) |
| **Copyright:** | Christoph Hartmann (<chris@lollyrock.com>) |
| **Copyright:** | Dominik Richter (<dominik.richter@gmail.com>) |
| **License:** | Mozilla Public License Version 2.0 |

The terraform aws example is based on their [two-tier example](https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier) which is also MPL-2.0 licensed.

