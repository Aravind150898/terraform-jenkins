output "jenkins_master_public_ip" {
  description = "Public IP address of the Jenkins master EC2 instance"
  value       = module.ec2_instance.public_ip
}

