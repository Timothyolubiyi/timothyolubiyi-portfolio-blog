resource "aws_acm_certificate" "portfolio" {
  count             = var.certificate_arn == "" ? 1 : 0
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project}-certificate"
    }
  )
}

resource "aws_route53_record" "cert_validation" {
  for_each = var.use_route53 && var.certificate_arn == "" ? {
    for dvo in aws_acm_certificate.portfolio[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  } : {}

  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = each.value.name
  type    = each.value.type
  records = [each.value.record]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "portfolio" {
  count           = var.certificate_arn == "" ? 1 : 0
  certificate_arn = aws_acm_certificate.portfolio[0].arn

  timeouts {
    create = "5m"
  }

  depends_on = [aws_route53_record.cert_validation]
}

resource "aws_route53_record" "cloudfront" {
  count   = var.use_route53 ? 1 : 0
  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = var.domain_name
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "cloudfront_www" {
  count   = var.use_route53 ? 1 : 0
  zone_id = data.aws_route53_zone.primary[0].zone_id
  name    = "www.${var.domain_name}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.portfolio.domain_name
    zone_id                = aws_cloudfront_distribution.portfolio.hosted_zone_id
    evaluate_target_health = true
  }
}
