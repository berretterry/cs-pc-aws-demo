resource "aws_security_group" "windows_server" {
  name_prefix = "${var.name}-windows-server"
  description = "allows 3389"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 3389
    to_port         = 3389
    protocol        = "tcp"
    security_groups = [var.pc_worker_sg]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge({ Name = "${var.name}-rdp" }, var.tags)
}