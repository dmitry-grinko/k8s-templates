# VPC Module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.5.1"

  name = "${var.project_name}-${var.environment}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws-region}a", "${var.aws-region}b", "${var.aws-region}c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  # Tags required for EKS
  tags = {
    Environment = var.environment
    Project     = var.project_name
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
    "kubernetes.io/cluster/${var.project_name}-${var.environment}" = "shared"
  }
}

# EKS Module
module "eks" {
  source = "./modules/eks"

  project_name      = var.project_name
  environment       = var.environment
  vpc_id           = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  # Node group configuration with cost-optimized settings
  cluster_version  = "1.27"
  instance_types   = ["t3.small"]
  desired_size     = 1
  min_size         = 1
  max_size         = 2

  depends_on = [module.vpc]
}
