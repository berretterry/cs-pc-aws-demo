resource "aws_security_group" "web_page" {
  name_prefix = "${var.name}-web-page"
  description = "allow inbound from strongDM gateway"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = "${var.name}-http" }, var.tags)
}

resource "aws_security_group_rule" "allow_80" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.pc_worker_sg
  security_group_id        = aws_security_group.web_page.id
}
resource "aws_security_group_rule" "allow_http_ssh" {
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  source_security_group_id = var.pc_worker_sg
  security_group_id        = aws_security_group.web_page.id
}