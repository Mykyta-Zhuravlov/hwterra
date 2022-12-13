resource "aws_db_instance" "database" {

  allocated_storage      = var.db_storage
  engine                 = var.db_engine
  engine_version         = var.db_version
  instance_class         = var.db_inst_type
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_private.id
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  name                   = var.db_name
  username               = data.aws_ssm_parameter.db_user_ssm.value
  password               = data.aws_ssm_parameter.db_password_ssm.value
  skip_final_snapshot    = var.db_skip_final_snapshot

  tags = {
    Name = var.db_name
  }

}

data "aws_ssm_parameter" "db_password_ssm" {
  name = var.db_password_ssm
}
data "aws_ssm_parameter" "db_user_ssm" {
  name = var.db_user_ssm
}
