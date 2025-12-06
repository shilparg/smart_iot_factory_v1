output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ec2_instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "secretsmanager_policy_arn" {
  value = aws_iam_policy.secretsmanager_policy.arn
}
