terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

#create a s3 bucket

resource "aws_s3_bucket" "first_bucket" {
  bucket = "terraform-tutorial-20261021"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}


