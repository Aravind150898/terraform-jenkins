resource "aws_instance" "jenkins_master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  iam_instance_profile   = var.iam_role_name
  vpc_security_group_ids = [var.security_group]
  associate_public_ip_address = true

  tags = {
    Name = "Jenkins Master"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 50  # Size in GB
    volume_type = "gp3"  # General Purpose SSD, you can choose other types (e.g., gp2, io1)
    delete_on_termination = true  # Automatically delete the EBS volume when the instance is terminated
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

