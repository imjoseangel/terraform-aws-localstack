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
