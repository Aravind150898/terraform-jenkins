variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the Jenkins master EC2"
  type        = string
  default     = "t4g.medium"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "key_name" {
  description = "SSH Key name to access the EC2 instance"
  type        = string
}

variable "region" {
  description = "AWS region to launch resources in"
  type        = string
  default     = "us-east-1"
}

