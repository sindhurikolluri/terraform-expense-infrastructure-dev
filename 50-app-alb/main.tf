module "alb" {
  source = "terraform-aws-modules/alb/aws"
  internal = true
  #internal is true because it is for private subnets
  # expense-dev-app-alb
  name    = "${var.project_name}-${var.environment}-app-alb"
  vpc_id  = data.aws_ssm_parameter.vpc_id.value
  subnets = local.private_subnet_ids
  create_security_group = false
#because in the module we are fetching the default value is true but we are keeping it as false because we want to keep our security group 
  security_groups = [local.app_alb_sg_id]
  enable_deletion_protection = false
  #
  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.environment}-app-alb"
    }
  )
}