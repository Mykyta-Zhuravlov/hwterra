resource "aws_vpc" "wordpress_vpc" {

  cidr_block = var.cidr_vpc

  tags = {
    Name = var.vpc_name
  }

}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wordpress_vpc.id

  tags = {
    Name = var.igw_name
  }

}


resource "aws_route_table" "route_table" {

  vpc_id = aws_vpc.wordpress_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = var.route_table_name
  }

}


resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_1
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = data.aws_availability_zones.available.names[0]
  tags = {
    Name = "${var.public_subnets_name}_1"
  }

}


resource "aws_subnet" "public_2" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_2
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.public_subnets_name}_2"
  }

}


resource "aws_subnet" "public_3" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_3
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = data.aws_availability_zones.available.names[2]
  tags = {
    Name = "${var.public_subnets_name}_3"
  }

}


resource "aws_subnet" "private_1" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_1
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "${var.private_subnets_name}_1"
  }

}


resource "aws_subnet" "private_2" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_2
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "${var.private_subnets_name}_2"
  }

}


resource "aws_subnet" "private_3" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_3
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = data.aws_availability_zones.available.names[2]

  tags = {
    Name = "${var.private_subnets_name}_3"
  }

}


resource "aws_db_subnet_group" "subnet_group_private" {

  subnet_ids = ["${aws_subnet.private_1.id}", "${aws_subnet.private_2.id}", "${aws_subnet.private_3.id}"]

}


resource "aws_route_table_association" "route_table_association" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_1.id

}
resource "aws_route_table_association" "route_table_association2" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_2.id

}
resource "aws_route_table_association" "route_table_association3" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_3.id

}


resource "aws_lb" "app_lb" {

  name               = var.load_balancer_name
  internal           = var.load_balancer_internal
  load_balancer_type = var.load_balancer_type
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = [aws_subnet.public_1.id, aws_subnet.public_2.id, aws_subnet.public_3.id]

  tags = {
    Name = var.load_balancer_name
  }
}


resource "aws_lb_target_group" "alb_tg" {

  name        = var.load_balancer_target_name
  target_type = var.load_balancer_target_type
  port        = var.load_balancer_target_port
  protocol    = var.load_balancer_target_protocol
  vpc_id      = aws_vpc.wordpress_vpc.id
}


resource "aws_lb_listener" "front_end" {

  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.load_balancer_target_port
  protocol          = var.load_balancer_target_protocol
  default_action {
    type = var.load_balancer_target_default_action_type

    redirect {
      port        = var.load_balancer_https_port
      protocol    = var.load_balancer_https_protocol
      status_code = var.load_balancer_https_status_code
    }
  }
}


resource "aws_lb_listener" "front_end2" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = var.load_balancer_https_port
  protocol          = var.load_balancer_https_protocol
  ssl_policy        = var.load_balancer_https_policy
  certificate_arn   = aws_acm_certificate.cert.arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

