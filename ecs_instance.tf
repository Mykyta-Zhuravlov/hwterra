

resource "aws_instance" "ecs-instance01" {

  ami                         = var.ecs_instance_ami
  instance_type               = var.ecs_instance_type
  availability_zone           = var.az_1
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
