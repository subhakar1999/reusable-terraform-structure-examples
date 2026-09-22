bucket         = "my-iac-tfstate-prod"
key            = "prod/terraform.tfstate"
region         = "us-east-1"
dynamodb_table = "terraform-locks"
encrypt        = true
kms_key_id     = "alias/terraform-state-key"
