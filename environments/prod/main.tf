terraform {
  backend "s3" {} # values supplied via -backend-config=backend.tfvars
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  cidr_block         = "10.30.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 3)
}

module "s3_secure" {
  source = "../../modules/s3"

  name_prefix = local.name_prefix
  bucket_name = "myapp-prod-artifacts"
}
