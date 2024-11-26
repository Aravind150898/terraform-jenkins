resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
}

output "subnet_id" {
  value = aws_subnet.jenkins_subnet.id
}

