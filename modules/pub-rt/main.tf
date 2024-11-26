resource "aws_route_table" "jenkins_public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }
}

resource "aws_route_table_association" "jenkins_subnet_association" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.jenkins_public_rt.id
}

output "route_table_id" {
  value = aws_route_table.jenkins_public_rt.id
}

