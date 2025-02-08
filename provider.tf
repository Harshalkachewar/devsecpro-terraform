terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
access_key = "AKIASU566OZOAE4BXNEB"
secret_key = "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"
}
