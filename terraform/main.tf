terraform {

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }

  }

}

provider "aws" {
  region = var.aws_region
}

data "aws_caller_identity" "current" {}

data "aws_route53_zone" "primary" {
  count = var.use_route53 ? 1 : 0
  name  = var.domain_name
}