# Terraform AWS

[![Terraform CI](https://github.com/imjoseangel/terraform-aws/actions/workflows/terraform.yml/badge.svg)](https://github.com/imjoseangel/terraform-aws/actions/workflows/terraform.yml)

## Deploys an AWS EC2 and DynamoDB on LocalStack

The following repository shows the way to create an EC2 instance connected to a DynamoDB with [LocalStack](https://github.com/localstack/localstack). All the test are running automatically and using GitHub Actions.

### NOTES

* Automatically test the code with [LocalStack](https://github.com/localstack/localstack).
* Automatically uses [tfsec](https://github.com/tfsec/tfsec) for security testing.
* Implements [pre-commit](https://pre-commit.com/)  for static testing
* Implements [EditorConfig](https://editorconfig.org/) for file format.

### How to use this repository

Configure the following environment variables for your local tests:

```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

In a local dev environment, these could be setup as:

```bash
export AWS_ACCESS_KEY_ID=test
export AWS_SECRET_ACCESS_KEY=test
```

Recommended the use of localstack in docker running:

```bash
docker-compose -f docker-compose.yaml up -d
```

## CI Reference

Check the [GitHub Actions](.github/workflows/terraform.yml) for pipeline testing reference. Different techniques has been applied to test Terraform code, whether statically and with [LocalStack](https://github.com/localstack/localstack).

### Password protection

For **Production environments** use a protected pipeline with a secret manager solution (Recommended [Hashicorp Vault](https://www.vaultproject.io/)).

Check how the passwords are used under [GitHub Actions](.github/workflows/terraform.yml) for pipeline testing or production deployment reference.

[GitGuardian](https://github.com/GitGuardian) is enabled in the repository to avoid secret leaks.

### Pre-commit and editor config

* Use [pre-commit](https://pre-commit.com/) hooks in this repository to ensure security and formatting for terraform, detect passwords and other static checks before uploading code.

* Use [EditorConfig](https://editorconfig.org/) in your IDE for file formatting.

### Makefile

A makefile has been added to make the cleaning and test easier. Run `make help` to review options.

## Terraform

The solution reflected in this repository connects an EC2 instance with DynamoDB by using IAM Policies. Official AWS Modules have been used for EC2 and security group and avoided for the rest of the components for the sake of simplicity. I always recommend local maintained and secured modules with local policies.

## Authors

Originally created by [imjoseangel](http://github.com/imjoseangel)

## License

[MIT](LICENSE)
