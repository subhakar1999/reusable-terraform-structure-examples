terraform {
  backend "s3" {} # values supplied via -backend-config=backend.tfvars
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  cidr_block         = "10.20.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}
