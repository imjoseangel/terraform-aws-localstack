terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = ">= 3.24"
  }
}

provider "aws" {
  region                      = local.region
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = "http://localhost:4566"
    ec2      = "http://localhost:4566"
    iam      = "http://localhost:4566"
  }
}
