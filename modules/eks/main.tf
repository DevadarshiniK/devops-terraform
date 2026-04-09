module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.34"

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  enable_irsa = true 

  # Control plane access
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true

  enable_cluster_creator_admin_permissions = true

  tags = var.tags
}