# Deploy your own private cloud with OpenStack on AWS

## Blog post

- **FR:** https://www.padok.fr/blog/openstack-cloud-prive
- **EN:** TBD

## Requirements

- an AWS account
- [Terraform](https://www.terraform.io/) installed

## Getting started

Everything happens in the `infrastructure` folder:

```bash
cd infrastructure
```

1. Copy `terraform.tfvars.tbd` into `terraform.tfvars`
2. Add your public SSH key in this file
3. Deploy the infrastructure

    ```bash
    terraform init
    terraform workspace new openstack-test
    terraform apply # type 'yes' to confirm
    ```

4. You can connect to your newly created VM. Follow the rest of the article to deploy OpenStack.

    ```bash
    ssh -i <PRIVATE_KEY_PATH> ubuntu@<PUBLIC_IP>
    ```

### Destroy the infrastructure

```bash
terraform destroy # type 'yes' to confirm
```

## License

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
