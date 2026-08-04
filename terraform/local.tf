locals {
  project     = var.project_name
  environment = var.environment
  region      = var.aws_region
  domain      = var.domain_name

  s3_bucket_name = "${local.project}-${local.environment}-${data.aws_caller_identity.current.account_id}"

  certificate_arn = var.certificate_arn != "" ? var.certificate_arn : aws_acm_certificate.portfolio[0].arn

  common_tags = merge(
    var.tags,
    {
      Project     = local.project
      Environment = local.environment
      Region      = local.region
      ManagedBy   = "Terraform"
    }
  )
}