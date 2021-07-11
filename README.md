# Terraform AWS

## Deploys an AWS EC2 and DynamoDB on LocalStack

The following repository shows the way to create an EC2 instance connected to a DynamoDB with LocalStack. All the test are running automatically and using GitHub Actions.

### NOTES

* Automatically test the code with [localstack](https://github.com/localstack/localstack).
* Automatically uses tfsec for security testing.
* Implements `pre-commit` for static testing
* Implements `editorconfig` for file format.

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

#### Password protection

For production environments use a protected pipeline with a secret manager solution (Recommended [Hashicorp Vault](https://www.vaultproject.io/)).

Check how the passwords are used under [GitHub Actions](.github/workflows/terraform.yml) for pipeline testing or production deployment reference.

If something goes wrong, [GitGuardian](https://github.com/GitGuardian) is enabled in the repository to avoid passwords leaking.

#### Pre-commit

Use the [pre-commit](https://pre-commit.com/) hooks in this repository to ensure security and formatting for terraform, detect passwords and other static checks before uploading code.

## Authors

Originally created by [imjoseangel](http://github.com/imjoseangel)

## License

[MIT](LICENSE)
