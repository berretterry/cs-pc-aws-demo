data "aws_ami" "windows_server" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2022-English-Full-Base*"]
  }
}

resource "aws_instance" "windows_server" {
  ami           = data.aws_ami.windows_server.image_id
  instance_type = "t3a.medium"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.windows_server.id]

  get_password_data = true
  key_name          = aws_key_pair.windows_key.key_name
  # This key is used to encrypt the windows password

  tags = merge({ Name = "${var.name}-rdp" }, var.tags)
}