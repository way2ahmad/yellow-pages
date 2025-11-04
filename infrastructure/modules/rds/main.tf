resource "aws_db_instance" "postgres" {
identifier = var.db_name
engine = "postgres"
instance_class = "db.t3.micro"
allocated_storage = 20
name = var.db_name
username = var.db_username
password = var.db_password
skip_final_snapshot = true
vpc_security_group_ids = var.vpc_security_group_ids
db_subnet_group_name = aws_db_subnet_group.default.name
}


resource "aws_db_subnet_group" "default" {
name = "rds-subnet-group"
subnet_ids = var.subnet_ids
}