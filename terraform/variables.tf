variable "aws_region" {
  type        = string
  description = "AWS region"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "ec2_name" {
  type        = string
  description = "EC2 instance name"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID for the Security Group"
}

variable "security_group_name" {
  type        = string
  description = "Security Group name"
}

variable "security_group_description" {
  type        = string
  description = "Security Group description"
}

variable "web_port" {
  type        = number
  description = "HTTP port"
}

variable "ssh_port" {
  type        = number
  description = "SSH port"
}

variable "ssh_cidr" {
  type        = string
  description = "Allowed SSH source IP"
}
