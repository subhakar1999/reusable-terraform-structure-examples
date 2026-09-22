terraform {
  backend "s3" {} # values supplied via -backend-config=backend.tfvars
}

module "vpc" {
  source = "../../modules/vpc"

  name_prefix        = local.name_prefix
  cidr_block         = "10.10.0.0/16"
  availability_zones = slice(data.aws_availability_zones.available.names, 0, 2)
}

module "ec2" {
  source = "../../modules/ec2"

  name_prefix  = local.name_prefix
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.private_subnet_ids
  instance_type = "t3.micro"
}
