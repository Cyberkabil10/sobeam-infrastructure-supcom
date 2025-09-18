aws_region         = "eu-west-3"
vpc_name           = "dev-vpc"
vpc_cidr_block     = "10.0.0.0/16"
availability_zones = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
environment        = "dev"
