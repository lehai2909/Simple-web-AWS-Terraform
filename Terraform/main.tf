terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
resource "aws_instance" "my_app_server" {
  ami           = "ami-013a129d325529d4d"
  instance_type = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.terraform-instance-profile.name
  user_data = "${file("install_node.sh")}"
  tags = {
    Name = "terraform-ExampleAppServerInstance"
  }
}

resource "aws_dynamodb_table" "terraform-dynamodb-table" {
  name             = "HelloWorldDatabase"
  hash_key         = "ID"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "ID"
    type = "S"
  }

}

resource "aws_vpc" "terraform-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "terraform-vpc"
  }
}


resource "aws_subnet" "terraform-subnet" {
  vpc_id     = aws_vpc.terraform-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "terraform-subnet"
  }
}

resource "aws_internet_gateway" "terraform-igw" {
  vpc_id = aws_vpc.terraform-vpc.id

  tags = {
    Name = "terraform-igw"
  }
}



resource "aws_iam_role" "terraform-role" {
  name = "terraform-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "terraform-policy" {
  name        = "terraform-policy"
  description = "A test policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.terraform-role.name
  policy_arn = aws_iam_policy.terraform-policy.arn
}

resource "aws_iam_instance_profile" "terraform-instance-profile" {
  name = "terraform-profile"
  role = aws_iam_role.terraform-role.name
}


