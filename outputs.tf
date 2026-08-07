output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value       = aws_instance.dev_server.public_ip
}

output "instance_id" {
    description = "ID of the EC2 instance"
    value       = aws_instance.dev_server.id

}

output "instance_tags"{
    description = "Tags associated with the EC2 instance"
    value       = aws_instance.dev_server.tags
}