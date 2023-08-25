terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.14.0"
    }
  }
}

provider "aws" {

  access_key = "mock_access_key"
  secret_key = "mock_secret_key"
  region     = local.region

  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb        = "http://localhost:4566"
    ec2             = "http://localhost:4566"
    iam             = "http://localhost:4566"
    networkfirewall = "http://localhost:4566"
    networkmanager  = "http://localhost:4566"
    s3              = "http://localhost:4566"
  }
}
