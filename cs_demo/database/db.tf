resource "aws_db_subnet_group" "mysql_subnet" {
  name       = "mysql_subnet"
  subnet_ids = var.subnet_ids
}

resource "aws_db_instance" "mysql_rds" {
  allocated_storage       = 10
  db_name                 = local.database
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = local.username
  password                = local.password
  parameter_group_name    = "default.mysql8.0"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.mysql.id]
  db_subnet_group_name    = aws_db_subnet_group.mysql_subnet.name
  backup_retention_period = 1

  tags = merge({ Name = "${var.name}-mysql" }, var.tags)
}

resource "aws_db_instance" "mysql_rds_replica" {
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  password               = local.password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.mysql.id]
  replicate_source_db    = aws_db_instance.mysql_rds.identifier

  tags = merge({ Name = "${var.name}-mysql-replica" }, var.tags)
}