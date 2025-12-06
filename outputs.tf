output "sim_host_public_ip" {
  description = "Public IP of the IoT simulator host"
  value       = module.ec2.public_ip
}

output "sim_host_public_dns" {
  description = "Public DNS of the IoT simulator host"
  value       = module.ec2.public_dns
}

output "grafana_url" {
  value = "http://${module.ec2.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${module.ec2.public_ip}:9090"
}

output "iot_certificate_arn" {
  value = module.iot.certificate_arn
}

output "iot_certificate_id" {
  value = module.iot.certificate_id
}

output "iot_thing_name" {
  value = module.iot.iot_thing_name
}

output "iot_policy_name" {
  value = module.iot.iot_policy_name
}

output "cert_bucket_name" {
  value = module.s3_config.cert_bucket_name
}

output "config_bucket_name" {
  value = module.s3_config.config_bucket_name
}

output "ec2_role_name" {
  value = module.iam.ec2_role_name
}

output "secretsmanager_policy_arn" {
  value = module.iam.secretsmanager_policy_arn
}
