# DB Subnet for RDS
resource "aws_db_subnet_group" "default" {
  name = "${var.project}-db-subnet-group"
  subnet_ids = aws_subnet.private_subnet.*.id

  tags = {
      Name = "${var.project}-db-subnet-group"
  }
}

# RDS
resource "aws_db_instance" "rds" {
  allocated_storage = 20
  db_subnet_group_name = aws_db_subnet_group.default.name
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t2.micro"
  name = "${var.project}db"
  username = "$DB_USERNAME"
  password = "$DB_PASSWORD"
  port = 3306
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot = true
  parameter_group_name = aws_db_parameter_group.rds_parameter.name

  tags = {
      Name = "${var.project}-db"
  }
}

resource "aws_db_parameter_group" "rds_parameter" {
  name = "${var.project}-db-parameter"
  family = "mysql5.7"

  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name         = "time_zone"
    value        = "Asia/Tokyo"
  }
}
