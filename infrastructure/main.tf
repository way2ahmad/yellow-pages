provider "aws" {
region = var.region
}


module "vpc" {
source = "./modules/vpc"
vpc_cidr = var.vpc_cidr
public_subnet_cidrs = var.public_subnet_cidrs
}


module "s3_cloudfront" {
source = "./modules/s3_cloudfront"
bucket_name = "yellow-pages-frontend"
}


module "ecs" {
source = "./modules/ecs"
cluster_name = "yellow-pages-cluster"
alb_name = "yellow-pages-alb"
vpc_id = module.vpc.vpc_id
public_subnet_ids = module.vpc.public_subnet_ids
}


module "rds" {
source = "./modules/rds"
db_name = "yellowpages"
db_username = var.db_username
db_password = var.db_password
subnet_ids = module.vpc.public_subnet_ids
vpc_security_group_ids = [module.ecs.ecs_security_group_id]
}