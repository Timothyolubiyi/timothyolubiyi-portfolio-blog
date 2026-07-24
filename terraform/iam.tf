data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

# GitHub OIDC provider - already exists in account, using existing
# Uncomment below to create new OIDC provider if it doesn't exist
# data "aws_iam_openid_connect_provider" "github" {
#   url = "https://token.actions.githubusercontent.com"
# }

# If creating new provider:
# resource "aws_iam_openid_connect_provider" "github" {
#   client_id_list  = ["sts.amazonaws.com"]
#   thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
#   url             = data.tls_certificate.github.url
# }

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions" {
  name = "${local.project}-github-actions-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }
          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Timothyolubiyi/*:*"
          }
        }
      }
    ]
  })

  tags = local.common_tags
}

resource "aws_iam_role_policy" "github_actions_s3" {
  name = "${local.project}-github-actions-s3-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.portfolio.arn}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.portfolio.arn
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_actions_cloudfront" {
  name = "${local.project}-github-actions-cloudfront-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "cloudfront:CreateInvalidation",
          "cloudfront:GetDistribution"
        ]
        Resource = "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.portfolio.id}"
      }
    ]
  })
}

resource "aws_iam_role_policy" "github_actions_iam" {
  name = "${local.project}-github-actions-iam-policy"
  role = aws_iam_role.github_actions.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "iam:GetRole",
          "iam:PassRole"
        ]
        Resource = aws_iam_role.github_actions.arn
      }
    ]
  })
}
