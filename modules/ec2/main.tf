resource "aws_instance" "jenkins_master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  iam_instance_profile   = var.iam_role_name
  security_group         = var.security_group
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins Master"
  }
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras enable java-openjdk17
              yum install -y java-17-openjdk
              curl -fsSL https://get.jenkins.io/war/2.479/jenkins.war -o /tmp/jenkins.war
              java -jar /tmp/jenkins.war --httpPort=8080 &
            EOF

}

output "public_ip" {
  value = aws_instance.jenkins_master.public_ip
}

