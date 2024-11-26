variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet"
  type        = string
}

variable "key_name" {
  description = "Name of the SSH key"
  type        = string
}

variable "iam_role_name" {
  description = "IAM Role Name"
  type        = string
}

# modules/ec2/variables.tf

variable "iam_instance_profile_name" {
  description = "The IAM instance profile to associate with the EC2 instance"
  type        = string
}


variable "security_group" {
  description = "Security Group ID"
  type        = string
}



