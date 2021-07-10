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

#---------------------------------------------------------
# Create DynamoDB
#---------------------------------------------------------

resource "aws_dynamodb_table" "main" {

  name             = "exampledb"
  hash_key         = "id"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"
  read_capacity    = 1
  write_capacity   = 1

  attribute {
    name = "id"
    type = "S"
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
        "Action" : "dynamodb:*",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ec2_attach" {
  role       = aws_iam_role.ec2_dynamodb_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2_dynamodb_role.name
}

# ---------------------------------------------------------
# Create EC2 using module - Ideally the VPC and other
# components should use the same approach
# ---------------------------------------------------------

module "ec2" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = var.ec2_name
  instance_count = var.ec2_instance_count

  ami                  = var.ec2_ami
  instance_type        = var.ec2_instance_type
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  subnet_id            = aws_subnet.vpc_private_subnet.id

  tags = merge({ "ResourceName" = format("%s", var.ec2_name) }, var.tags, )
}
