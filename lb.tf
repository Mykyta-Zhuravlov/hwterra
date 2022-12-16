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
