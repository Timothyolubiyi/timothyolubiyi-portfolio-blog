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
  backend "s3" {
    bucket  = "timothy-portfolio-tfstate"
    key     = "portfolio/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region
}


data "aws_route53_zone" "primary" {
  count = var.use_route53 ? 1 : 0
  name  = var.domain_name
}