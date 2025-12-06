variable "environment" {
  type        = string
  description = "Deployment environment (e.g., dev, staging, prod)"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for simulator host"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID where the EC2 instance will be launched"
}

variable "security_group_id" {
  type        = string
  description = "Security group ID to associate with the EC2 instance"
}

variable "key_name" {
  type        = string
  description = "SSH keypair name for EC2 instance access"
}

variable "iam_instance_profile" {
  type        = string
  description = "IAM instance profile name attached to the EC2 instance"
}

variable "user_data" {
  type        = string
  description = "User data script for EC2 initialization (e.g., bootstrap configuration)"
}