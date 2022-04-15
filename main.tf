#---------------------------------------------------------
# Create Basic VPC and Subnet
#---------------------------------------------------------
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

resource "aws_subnet" "vpc_private_subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.vpc_private_subnet
}

#-------------------------------
# S3 Bucket
#-------------------------------
#tfsec:ignore:aws-s3-enable-bucket-logging
resource "aws_s3_bucket" "main" {
  bucket        = var.s3name
  force_destroy = false

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Terraform = "true"
  }
}

resource "aws_s3_bucket_acl" "main" {
  bucket = aws_s3_bucket.main.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_kms_key" "main" {
  count                   = var.sse_algorithm == "aws:kms" ? 1 : 0
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
  enable_key_rotation     = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "main" {
  bucket = aws_s3_bucket.main.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.sse_algorithm == "aws:kms" ? aws_kms_key.main[0].arn : null
      sse_algorithm     = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  ignore_public_acls      = true
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket.main]
}


#---------------------------------------------------------
# Create Security Group
#---------------------------------------------------------

resource "aws_security_group" "allow_icmp" {
  name        = "allow_icmp"
  description = "Allow ICMP inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "ICMP from VPC"
    protocol    = "icmp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "allow_icmp"
  }
}

#-------------------------------
# DynamoDB
#-------------------------------
#tfsec:ignore:aws-dynamodb-enable-recovery
resource "aws_dynamodb_table" "main" {
  name         = var.db_name
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  #TODO: read_capacity  = 2
  #TODO: write_capacity = 2

  server_side_encryption {
    enabled     = true
    kms_key_arn = aws_kms_key.main[0].arn
  }

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name    = var.db_name
    BuiltBy = "Terraform"
  }
}

#---------------------------------------------------------
# Create IAM for EC2 and DynamoDB
#---------------------------------------------------------

resource "aws_iam_role" "ec2_dynamodb_role" {
  name = "ec2_dynamodbrole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "ec2.amazonaws.com"
          ]
        },
        "Action" : [
          "sts:AssumeRole"
        ]
      }
    ]
  })
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_policy"
  description = "ec2 policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "exampledb",
        "Effect" : "Allow",
        "Action" : "dynamodb:createTable",
        "Resource" : "dynamodb"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_dynamodb_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_dynamodb_role.name
  lifecycle {
    create_before_destroy = true
  }
}

# ---------------------------------------------------------
# Create EC2 using module - Ideally the VPC and other
# components should use the same approach
# ---------------------------------------------------------
resource "aws_network_interface" "main" {
  subnet_id   = aws_subnet.vpc_private_subnet.id
  private_ips = ["10.0.1.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "main" {
  ami           = "ami-005e54dee72cc1d00"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }
}
