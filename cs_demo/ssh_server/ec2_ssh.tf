data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
resource "aws_instance" "web_page" {
  ami           = data.aws_ami.al2023.id
  instance_type = "t3.micro"

  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_page.id]

  # Configures a simple HTTP web page
  user_data = templatefile("${path.module}/templates/http_install/http_install.tftpl", { SSH_PUB_KEY = var.ssh_pubkey })
  tags      = merge({ Name = "${var.name}-http" }, var.tags)
}
