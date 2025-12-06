data "aws_availability_zones" "available" {
  state = "available"
}

########################################
# Modules
########################################

module "network" {
  source = "./modules/network"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
}

module "iam" {
  source = "./modules/iam"

  region      = var.region
  environment = var.environment
}

module "iot" {
  source = "./modules/iot"

  region      = var.region
  environment = var.environment
  iot_topic   = var.iot_topic
}

module "s3_config" {
  source = "./modules/s3_config"

  region           = var.region
  environment      = var.environment
  create_buckets   = var.create_buckets
  #config_s3_bucket = var.config_s3_bucket
  #cert_s3_bucket   = var.cert_s3_bucket

  # Compose bucket names dynamically
  cert_s3_bucket    = "${var.cert_s3_bucket}-${var.environment}"
  config_s3_bucket  = "${var.config_s3_bucket}-${var.environment}"

    # Add this line
  cert_files        = var.cert_files
}

module "ec2" {
  source = "./modules/ec2"

  environment          = var.environment
  instance_type        = var.instance_type
  subnet_id            = module.network.public_subnet_id
  security_group_id    = module.network.ec2_sg_id
  key_name             = var.key_name
  iam_instance_profile = module.iam.ec2_instance_profile_name

  user_data = templatefile("${path.module}/user-data.sh.tpl", {
    simulator_count        = var.simulator_count
    cert_s3_bucket         = module.s3_config.cert_bucket_name
    config_s3_bucket       = module.s3_config.config_bucket_name
    region                 = var.region
    aws_endpoint           = module.iot.iot_endpoint
    iot_topic              = var.iot_topic
    alert_email_recipients = join(",", var.alert_email_recipients)
  })
}
