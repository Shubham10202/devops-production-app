output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.ec2.ec2_instance_id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = module.ec2.security_group_id
}

output "aws_region" {
  description = "AWS region where the infrastructure is deployed"
  value       = var.aws_region
}
