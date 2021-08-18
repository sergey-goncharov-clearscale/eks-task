resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "eks-nodes-${var.task_id}"
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = data.aws_subnet_ids.private_ids.ids
  instance_types = ["t3.micro"]
  remote_access {
    ec2_ssh_key = "sergey.goncharov"
  }

  tags = {
    "kubernetes.io/cluster/${aws_eks_cluster.eks.name}" = "owned"
  }
  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 1
  }
}