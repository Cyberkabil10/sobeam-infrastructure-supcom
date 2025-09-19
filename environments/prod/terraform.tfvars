aws_region         = "eu-west-3"
vpc_name           = "prod-vpc"
vpc_cidr_block     = "10.1.0.0/16"
availability_zones = ["eu-west-3a", "eu-west-3b", "eu-west-3c"]
private_subnets    = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
public_subnets     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
environment        = "prod"
