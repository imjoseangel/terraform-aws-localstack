variable "vpc_cidr" {
  description = "(Required) The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnet" {
  description = "The CIDR block for the VPC Private Subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "db_name" {
  description = "Name for the DynamoDB"
  type        = string
  default     = "mydynamodb"
}

variable "s3name" {
  description = "name of the S3 bucket"
  type        = string
  default     = "terraform-aws-s3-bucket"
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm. Valid values: AES256, aws:kms"
  type        = string
  default     = "aws:kms"
}
