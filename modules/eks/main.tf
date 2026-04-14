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

  # 🔥 VERY IMPORTANT (fixes kubectl access)
  enable_cluster_creator_admin_permissions = true

  # =========================
  # 🔥 NODE GROUP (SPOT)
  # =========================
  eks_managed_node_groups = {

  # 💸 Spot (Cost Optimization)
  spot_nodes = {
    desired_size = 2
    min_size     = 1
    max_size     = 3

    instance_types = [
      "t3.medium",
      "t3a.medium",
      "t3.small",
      "t3a.small"
    ]

    capacity_type = "SPOT"

    ami_type = "AL2023_x86_64_STANDARD"

    labels = {
      node_type = "spot"
    }

    tags = {
      Name = "${var.cluster_name}-spot-nodes"

      # 🔥 REQUIRED FOR AUTOSCALER
      "k8s.io/cluster-autoscaler/enabled"            = "true"
      "k8s.io/cluster-autoscaler/${var.cluster_name}" = "owned"
    }
  }
}

  tags = var.tags
}