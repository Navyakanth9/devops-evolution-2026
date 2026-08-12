output "instance_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "web_server_url" {
    description = "The URL of the web server"
    value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_command" {
    description = "The SSH command to connect to the EC2 instance"
    value       = "ssh -i C:/Users/amshu_e35w1je/OneDrive/Desktop/Nav/Devops-Evolution-2026/AWS/aws-pem.pem ec2-user@${aws_instance.web_server.public_ip}"
}