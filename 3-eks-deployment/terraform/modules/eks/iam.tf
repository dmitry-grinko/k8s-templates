resource "aws_iam_role_policy_attachment" "eks_alb_policy" {
  policy_arn = "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess"
  role       = aws_iam_role.eks_cluster.name
} 