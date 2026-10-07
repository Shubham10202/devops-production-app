output "ec2_instance_id" {
  description = "ID of the DevOps EC2 instance"
  value       = aws_instance.devops_server.id
}

output "security_group_id" {
  description = "ID of the DevOps Security Group"
  value       = aws_security_group.devops_sg.id
}

output "aws_region" {
  description = "AWS region where the infrastructure is deployed"
  value       = var.aws_region
}
