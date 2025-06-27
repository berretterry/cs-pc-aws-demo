locals {
hostname      = aws_instance.windows_server.private_ip
private_key   = tls_private_key.windows_server.private_key_pem
password      = aws_instance.windows_server.password_data
username      = aws_instance.windows_server.password_data
}