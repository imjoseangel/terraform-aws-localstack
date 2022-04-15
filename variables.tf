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

variable "prefix" {
  description = "Name to be used on all resources as prefix"
  type        = string
  default     = "default"
}

variable "ec2_instance_count" {
  description = "Number of ec2 instances to launch"
  type        = number
  default     = 1
}

variable "ec2_instance_type" {
  description = "The type of EC2 instance to start"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ami" {
  description = "The ami of EC2 instance to start"
  type        = string
  default     = "ami-ebd02392"
}

variable "tags" {
  description = "Tags to apply to all resources created."
  type        = map(string)
  default     = {}
}

variable "sg_name" {
  description = "Name for the security group"
  type        = string
  default     = "sg"
}

variable "db_name" {
  description = "Name for the DynamoDB"
  type        = string
  default     = "db"
}

variable "ec2_name" {
  description = "Name for the EC2"
  type        = string
  default     = "ec2"
}

variable "dynamo_hash_key" {
  description = "Hash Key for DynamoDB"
  type        = string
  default     = "id"
}

variable "dynamo_stream_view_type" {
  description = "Stream view type for DynamoDB"
  type        = string
  default     = "NEW_AND_OLD_IMAGES"
}

variable "dynamo_stream_enabled" {
  description = "Enable Stream for DynamoDB"
  type        = bool
  default     = true
}

variable "dynamo_encryption" {
  description = "Server Side Encryiption for DynamoDB"
  type        = bool
  default     = true
}

variable "dynamo_read" {
  description = "Read capacity for dynamodb table"
  type        = number
  default     = 1
}

variable "dynamo_write" {
  description = "Write capacity for dynamodb table"
  type        = number
  default     = 1
}

variable "s3name" {
  description = "name of the S3 bucket"
  type        = string
  default     = "terraform-aws-s3-bucket"
}

variable "versioning" {
  description = "Enable versioning"
  type        = bool
  default     = false
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm. Valid values: AES256, aws:kms"
  type        = string
  default     = "aws:kms"
}
