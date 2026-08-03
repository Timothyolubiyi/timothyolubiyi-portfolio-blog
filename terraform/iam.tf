##############################################
# Existing GitHub OIDC Provider
##############################################

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

##############################################
# GitHub Actions IAM Role
##############################################

resource "aws_iam_role" "github_actions" {
  name = "${local.project}-github-actions-role-v2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "GitHubOIDC"
        Effect = "Allow"

        Principal = {
          Federated = data.aws_iam_openid_connect_provider.github.arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          StringLike = {
            "token.actions.githubusercontent.com:sub" = "repo:Timothyolubiyi@86630962/timothyolubiyi-portfolio-blog@1309741854:*"
          }
        }
      }
    ]
  })

  tags = local.common_tags
}

##############################################
# GitHub Actions - S3 Permissions
##############################################

resource "aws_iam_role_policy" "github_actions_s3" {
  name = "${local.project}-github-actions-s3-policy"

  role = aws_iam_role.github_actions.name

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
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

##############################################
# GitHub Actions - CloudFront Permissions
##############################################

resource "aws_iam_role_policy" "github_actions_cloudfront" {
  name = "${local.project}-github-actions-cloudfront-policy"

  role = aws_iam_role.github_actions.name

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

##############################################
# GitHub Actions - IAM Permissions
##############################################

resource "aws_iam_role_policy" "github_actions_iam" {
  name = "${local.project}-github-actions-iam-policy"

  role = aws_iam_role.github_actions.name

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