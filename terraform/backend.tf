# This file provides optional backend configuration for storing Terraform state in S3
# Uncomment and configure if you want to use remote state management

# To use this backend:
# 1. Create an S3 bucket for state:
#    aws s3api create-bucket --bucket timothy-portfolio-terraform-state --region us-east-1
#
# 2. Enable versioning:
#    aws s3api put-bucket-versioning --bucket timothy-portfolio-terraform-state --versioning-configuration Status=Enabled
#
# 3. Enable encryption:
#    aws s3api put-bucket-encryption \
#      --bucket timothy-portfolio-terraform-state \
#      --server-side-encryption-configuration '{"Rules":[{"ApplyServerSideEncryptionByDefault":{"SSEAlgorithm":"AES256"}}]}'
#
# 4. Create DynamoDB table for state locking:
#    aws dynamodb create-table \
#      --table-name terraform-locks \
#      --attribute-definitions AttributeName=LockID,AttributeType=S \
#      --key-schema AttributeName=LockID,KeyType=HASH \
#      --billing-mode PAY_PER_REQUEST \
#      --region us-east-1
#
# 5. Uncomment the backend configuration below
# 6. Run: terraform init

# Uncomment below to enable S3 backend:
# terraform {
#   backend "s3" {
#     bucket         = "timothy-portfolio-terraform-state"
#     key            = "prod/terraform.tfstate"
#     region         = "us-east-1"
#     encrypt        = true
#     dynamodb_table = "terraform-locks"
#   }
# }
