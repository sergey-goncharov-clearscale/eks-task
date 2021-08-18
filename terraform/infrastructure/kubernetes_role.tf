# role for auto scaling
data "aws_iam_policy_document" "assume_role_with_oidc" {
  statement {
    effect = "Allow"

    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"

      identifiers = ["${aws_iam_openid_connect_provider.eks.arn}"]
    }

    condition {
        test     = "StringEquals"
        variable = "${aws_eks_cluster.eks.identity.0.oidc.0.issuer}:sub"
        values   = ["system:serviceaccount:${var.kubernetes_service_account_namespace}:${var.kubernetes_service_account_name}"]
    }
  }
}

resource "aws_iam_role" "kubernetes_role" {
  name                 = "kubernetes_role-${var.task_id}"  
  assume_role_policy = join("", data.aws_iam_policy_document.assume_role_with_oidc.*.json)
}

resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.kubernetes_role.name
  policy_arn = aws_iam_policy.auto_scaling_policy.arn
}

# role for access to ssm
# resource "aws_iam_role" "kubernetes_ssm" {

#   name = "kubernetes_role_ssm-${var.task_id}"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Federated": "${aws_iam_openid_connect_provider.eks.arn}"
#       },
#       "Action": "sts:AssumeRoleWithWebIdentity",
#       "Condition": {
#         "StringEquals": {
#           "${aws_eks_cluster.eks.identity.0.oidc.0.issuer}:sub": "system:serviceaccount:kube-system:aws-ssm-operator"
#         }
#       }
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_policy" "kubernetes_ssm" {
 
#   name   = "kubernetes_ssm_policy-${var.task_id}"
#   policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Effect": "Allow",
#             "Action": [
#                 "ssm:Describe*",
#                 "ssm:Get*",
#                 "ssm:List*"
#             ],
#             "Resource": "*"
#         }
#     ]
# }
# EOF
# }

# resource "aws_iam_policy_attachment" "kubernetes_ssm" {
#   name       = "ssm-policy-${var.task_id}"
#   roles      = [aws_iam_role.kubernetes_ssm.name]
#   policy_arn = aws_iam_policy.kubernetes_ssm.arn
# }