resource "tls_private_key" "windows_server" {
  # This resource is not recommended for production environements
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "windows_key" {
  key_name   = "${var.name}-terraform-key"
  public_key = tls_private_key.windows_server.public_key_openssh
}
