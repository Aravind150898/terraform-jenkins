module "vpc" {
  source   = "./modules/vpc"
  cidr     = var.vpc_cidr
}

module "subnet" {
  source   = "./modules/subnet"
  vpc_id   = module.vpc.vpc_id
  cidr     = var.subnet_cidr
}

module "internet_gateway" {
  source = "./modules/igw"
  vpc_id = module.vpc.vpc_id
}

module "public_route_table" {
  source             = "./modules/pub-rt"
  vpc_id             = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  subnet_id          = module.subnet.subnet_id
}

module "security_group" {
  source   = "./modules/security_group"
  vpc_id   = module.vpc.vpc_id
}

module "iam_role" {
  source   = "./modules/iam_role"
}

module "ec2_instance" {
  source         = "./modules/ec2"
  ami_id         = var.ami_id
  instance_type  = var.instance_type
  subnet_id      = module.subnet.subnet_id
  key_name       = var.key_name
  iam_role_name  = module.iam_role.role_name
  security_group = module.security_group.security_group_id
  iam_instance_profile_name = module.iam_role.jenkins_instance_profile_name
}

