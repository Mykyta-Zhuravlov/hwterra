resource "aws_db_instance" "database" {

  allocated_storage      = var.db_storage
  engine                 = var.db_engine
  engine_version         = var.db_version
  instance_class         = var.db_inst_type
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_private.id
  vpc_security_group_ids = ["${aws_security_group.db_sg.id}"]
  name                   = var.db_name
  username               = var.db_user
  password               = random_password.password.result
  skip_final_snapshot    = var.db_skip_final_snapshot

  tags = {
    Name = var.db_name
  }

}


resource "aws_instance" "ecs-instance01" {

  ami                         = data.aws_ami.aws_ami_ecs.id
  instance_type               = var.ecs_instance_type
  availability_zone           = data.aws_availability_zones.available.names[0]
  subnet_id                   = aws_subnet.public_1.id
  key_name                    = aws_key_pair.wordpress.id
  associate_public_ip_address = var.ecs_instance_associate_public_ip
  iam_instance_profile        = var.ecs_instance_iam_profile
  security_groups             = ["${aws_security_group.ecs_instance_sg.id}"]
  user_data                   = "#!/bin/bash\necho ECS_CLUSTER=${aws_ecs_cluster.cluster.name} > /etc/ecs/ecs.config"

  tags = {
    Name = var.ecs_instance_name
  }
}
