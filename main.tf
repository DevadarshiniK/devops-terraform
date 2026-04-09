module "vpc" {
  source = "./modules/vpc"

  project          = "devops-project"
  vpc_cidr         = "10.0.0.0/16"
  azs              = ["ap-south-1a", "ap-south-1b"]
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "eks" {
  source = "./modules/eks"

  cluster_name    = "devops-project"
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  tags = {
    Environment = "dev"
    Project     = "devops"
  }
}