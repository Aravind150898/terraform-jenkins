variable "vpc_id" {
  description = "VPC ID to associate the Route Table"
  type        = string
}

variable "internet_gateway_id" {
  description = "Internet Gateway ID to associate with the Route Table"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID to associate with the Route Table"
  type        = string
}

