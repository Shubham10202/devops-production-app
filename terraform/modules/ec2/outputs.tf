output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.this.id
}

output "security_group_id" {
  description = "ID of the Security Group"
  value       = aws_security_group.this.id
}
