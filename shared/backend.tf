# Remote state: S3 (KMS-encrypted) + DynamoDB locking
terraform {
  backend "s3" {
    bucket         = "my-iac-tfstate-prod"
    key            = "REPLACE/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
    kms_key_id     = "alias/terraform-state-key"
  }
}
