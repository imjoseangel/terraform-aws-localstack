# Terraform AWS

## Deploys an AWS EC2 and DynamoDB on LocalStack

The following repository shows the way to create an EC2 instance connected to a DynamoDB with LocalStack. All the test are running automatically and using GitHub Actions.

### NOTES

* Automatically test the code with [localstack](https://github.com/localstack/localstack).
* Automatically uses tfsec for security testing.
* Implements `pre-commit` for static testing
* Implements `editorconfig` for file format.

## Authors

Originally created by [imjoseangel](http://github.com/imjoseangel)

## License

[MIT](LICENSE)
