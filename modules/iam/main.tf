############################################
# IAM Role + Instance Profile
############################################

# Caller identity (needed for account_id interpolation)
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# Policy document for Secrets Manager access
data "aws_iam_policy_document" "secretsmanager_access" {
  statement {
    actions = ["secretsmanager:GetSecretValue"]
    resources = [
      "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:grafana/smtp-*"
    ]
    effect = "Allow"
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "iot-sim-ec2-role-${var.environment}"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_policy" "secretsmanager_policy" {
  name   = "iot-sim-dev-secretsmanager-policy"
  policy = data.aws_iam_policy_document.secretsmanager_access.json
}

resource "aws_iam_role_policy_attachment" "secretsmanager_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.secretsmanager_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy_attachment" "s3_read" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "iot-sim-ec2-profile-${var.environment}"
  role = aws_iam_role.ec2_role.name
}
