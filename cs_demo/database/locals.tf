locals {
  username = "strongdmadmin"
  password = "strongdmpassword!#123#!"
  database = "strongdmdb"
  hostname = aws_db_instance.mysql_rds.address
}