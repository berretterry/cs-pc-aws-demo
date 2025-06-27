resource "aws_security_group" "mysql" {
  name_prefix = "${var.name}-mysql"
  description = "allow inbound from strongDM proxy cluster worker"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({ Name = "${var.name}-http" }, var.tags)
}
resource "aws_security_group_rule" "allow_mysql" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = var.pc_worker_sg
  security_group_id        = aws_security_group.mysql.id
}