data "aws_subnet_ids" "private_ids" {

  depends_on = [
    aws_subnet.private
  ]
    vpc_id = aws_vpc.sandbox.id

    tags = {
        Name = "subnet-private-*"
    }
}

resource "aws_eks_cluster" "eks" {
  name     = "eks-${var.task_id}"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet_ids.private_ids.ids
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSClusterPolicy,
  ]
}