output "s3_bucket_name" {
  description = "S3 bucket name for React build artifacts"
  value       = aws_s3_bucket.portfolio.id
}

output "s3_bucket_arn" {
  description = "ARN of S3 bucket"
  value       = aws_s3_bucket.portfolio.arn
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.portfolio.domain_name
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID for cache invalidation"
  value       = aws_cloudfront_distribution.portfolio.id
}

output "cloudfront_zone_id" {
  description = "CloudFront zone ID for Route53 alias records"
  value       = aws_cloudfront_distribution.portfolio.hosted_zone_id
}

output "acm_certificate_arn" {
  description = "ARN of ACM SSL certificate"
  value       = local.certificate_arn
}

output "github_actions_role_arn" {
  description = "ARN of GitHub Actions deployment role"
  value       = aws_iam_role.github_actions.arn
}

output "deployment_commands" {
  description = "Commands to run for deployment"
  value = {
    upload_to_s3 = "aws s3 sync dist/ s3://${aws_s3_bucket.portfolio.id} --delete"
    invalidate_cf = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.portfolio.id} --paths '/*'"
  }
}

output "certificate_validation_records" {
  description = "DNS records needed for certificate validation (if ACM certificate was created)"
  value = var.certificate_arn == "" ? jsonencode([
    for dvo in aws_acm_certificate.portfolio[0].domain_validation_options : {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
      domain = dvo.domain_name
    }
  ]) : jsonencode({ message = "Certificate provided via variable" })
}
