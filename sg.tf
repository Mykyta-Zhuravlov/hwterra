

resource "aws_security_group" "db_sg" {

  vpc_id = aws_vpc.wordpress_vpc.id

  ingress {
    from_port       = var.port_db_ingress
    to_port         = var.port_db_ingress
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web_sg.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_db_name
  }

}




resource "aws_security_group" "web_sg" {

  vpc_id = aws_vpc.wordpress_vpc.id

  ingress {
    from_port   = var.port_web_ingress_1
    to_port     = var.port_web_ingress_1
    protocol    = "tcp"
    cidr_blocks = var.cidr_web_ingress_1
  }

  ingress {
    from_port   = var.port_web_ingress_2
    to_port     = var.port_web_ingress_2
    protocol    = "tcp"
    cidr_blocks = var.cidr_web_ingress_2
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_web_name
  }

}
