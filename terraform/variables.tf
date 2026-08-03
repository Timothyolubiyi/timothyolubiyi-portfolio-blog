variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "us-east-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-\\d{1}$", var.aws_region))
    error_message = "AWS region must be a valid region identifier."
  }
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "production"

  validation {
    condition     = contains(["production", "staging", "development"], var.environment)
    error_message = "Environment must be production, staging, or development."
  }
}

variable "project_name" {
  description = "Project identifier for resource naming"
  type        = string
  default     = "timothy-portfolio"

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.project_name))
    error_message = "Project name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "domain_name" {
  description = "Custom domain name for CloudFront certificate (e.g., timothyolubiyi.name.ng)"
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{0,61}[a-z0-9]?(\\.[a-z0-9][a-z0-9-]{0,61}[a-z0-9]?)*\\.[a-z]{2,}$", var.domain_name))
    error_message = "Domain name must be a valid domain name."
  }
}

variable "certificate_arn" {
  description = "ARN of existing ACM certificate (leave empty to create new one)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default = {
    Owner       = "Timothy Olubiyi"
    Project     = "Portfolio & Blog"
    ManagedBy   = "Terraform"
    Environment = "Production"
  }
}

variable "cache_max_age_index" {
  description = "Cache max age for index.html in seconds"
  type        = number
  default     = 300
}

variable "cache_max_age_assets" {
  description = "Cache max age for static assets in seconds"
  type        = number
  default     = 31536000
}

variable "enable_logging" {
  description = "Enable CloudFront access logging"
  type        = bool
  default     = true
}

variable "use_route53" {
  description = "Use Route 53 for DNS (set to false if using external DNS provider)"
  type        = bool
  default     = true
}

variable "web_acl_id" {
  description = "AWS WAF Web ACL ARN attached to CloudFront"
  type        = string
  default     = ""
}

variable "github_owner" {
  type    = string
  default = "Timothyolubiyi"
}

variable "github_repo" {
  type    = string
  default = "timothyolubiyi-portfolio-blog"
}