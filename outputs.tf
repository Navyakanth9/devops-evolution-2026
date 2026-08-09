# Root level outputs.tf

output prod_sever_ip {
  description = "The public IP address of the EC2 instance"
  value       = module.enterprise_web_app.instance_ip
}

output prod_web_server_url {
    description = "The URL of the web server"
    value       = module.enterprise_web_app.web_server_url
}
output prod_ssh_command {
    description = "The SSH command to connect to the EC2 instance"
    value       = module.enterprise_web_app.ssh_command
}