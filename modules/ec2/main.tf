# Generate an SSH private key and public key
resource "tls_private_key" "jenkins_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "jenkins_key" {
  key_name   = "jenkins_new"  # Specify the name of the key pair
  # Generate a new SSH key pair using a local file (private and public)
  public_key = tls_private_key.jenkins_key.public_key_openssh
}

# Save the private key locally on the instance where Terraform is run
resource "local_file" "private_key" {
  filename = "/tmp/jenkins_private_key.pem" # Save to /tmp or another directory
  content  = tls_private_key.jenkins_key.private_key_pem
}

resource "aws_instance" "jenkins_master" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = aws_key_pair.jenkins_key.key_name
  iam_instance_profile   = var.iam_instance_profile_name
  vpc_security_group_ids = [var.security_group]
  associate_public_ip_address = true
  #iam_instance_profile_name = module.iam_role.jenkins_instance_profile_name

  tags = {
    Name = "Jenkins_Master"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 50  # Size in GB
    volume_type = "gp3"  # General Purpose SSD, you can choose other types (e.g., gp2, io1)
    delete_on_termination = true  # Automatically delete the EBS volume when the instance is terminated
  }
  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y openjdk-17-jdk
              sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
              echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
              sudo apt-get update
              sudo apt-get install jenkins
	      apt-get install -y snapd
              snap install amazon-ssm-agent --classic
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
            EOF

}

output "private_key_path" {
  value = local_file.private_key.filename
  description = "Path to the private key file"
}

output "public_ip" {
  value = aws_instance.jenkins_master.public_ip
}
