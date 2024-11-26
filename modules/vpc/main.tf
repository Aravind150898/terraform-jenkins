resource "aws_vpc" "jenkins_vpc" {
  cidr_block = var.cidr
}

output "vpc_id" {
  value = aws_vpc.jenkins_vpc.id
}

