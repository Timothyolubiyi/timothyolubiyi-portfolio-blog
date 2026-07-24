resource "aws_cloudfront_origin_access_control" "portfolio" {
  name                              = "${local.project}-oac"
  description                       = "OAC for ${local.project} S3 bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "portfolio" {
  origin {
    domain_name              = aws_s3_bucket.portfolio.bucket_regional_domain_name
    origin_id                = "s3-portfolio"
    origin_access_control_id = aws_cloudfront_origin_access_control.portfolio.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  http_version        = "http2and3"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = true

    cache_policy_id = aws_cloudfront_cache_policy.index_html.id

    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern     = "/index.html"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = true

    cache_policy_id = aws_cloudfront_cache_policy.index_html.id

    viewer_protocol_policy = "redirect-to-https"
  }

  ordered_cache_behavior {
    path_pattern     = "*.js"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = true

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  ordered_cache_behavior {
    path_pattern     = "*.css"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = true

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  ordered_cache_behavior {
    path_pattern     = "*.png"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = false

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  ordered_cache_behavior {
    path_pattern     = "*.jpg"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = false

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  ordered_cache_behavior {
    path_pattern     = "*.gif"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = false

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  ordered_cache_behavior {
    path_pattern     = "*.svg"
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "s3-portfolio"
    compress         = true

    cache_policy_id = aws_cloudfront_cache_policy.static_assets.id

    viewer_protocol_policy = "https-only"
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
    error_caching_min_ttl = 300
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = local.certificate_arn
    ssl_support_method             = "sni-only"
    minimum_protocol_version       = "TLSv1.2_2021"
  }

  dynamic "logging_config" {
    for_each = var.enable_logging && length(aws_s3_bucket.logs) > 0 ? [1] : []
    content {
      include_cookies = false
      bucket          = aws_s3_bucket.logs[0].bucket_domain_name
      prefix          = "cloudfront-logs/"
    }
  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.project}-cloudfront"
    }
  )
}

resource "aws_cloudfront_cache_policy" "index_html" {
  name = "${local.project}-index-html-cache-policy"

  default_ttl = var.cache_max_age_index
  max_ttl     = var.cache_max_age_index
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}

resource "aws_cloudfront_cache_policy" "static_assets" {
  name = "${local.project}-static-assets-cache-policy"

  default_ttl = var.cache_max_age_assets
  max_ttl     = var.cache_max_age_assets
  min_ttl     = 0

  parameters_in_cache_key_and_forwarded_to_origin {
    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "none"
    }

    cookies_config {
      cookie_behavior = "none"
    }

    enable_accept_encoding_gzip   = true
    enable_accept_encoding_brotli = true
  }
}
