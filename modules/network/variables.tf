variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for public subnet"
}

variable "environment" {
  type    = string
  default = "dev"
  description = "Deployment environment (e.g., dev, staging, prod)"
}

variable "allowed_cidr" {
  type        = string
  default     = "0.0.0.0/0"
  description = "CIDR block allowed to access EC2 services (e.g., SSH, Grafana, Prometheus)"
}