resource "aws_iam_role" "this_eks" {
  name_prefix = "${var.name}-"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCurrentUser"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow"
        Principal = {
          AWS = var.worker_role_arn
        }
        Action = "sts:AssumeRole"
      },
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = [
            "eks.amazonaws.com",
            "pods.eks.amazonaws.com"
          ]
        }
      },
    ]
  })
}
resource "aws_iam_role_policy_attachment" "this_eks" {
  role       = aws_iam_role.this_eks.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}