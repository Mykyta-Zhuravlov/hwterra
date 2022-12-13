resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_1
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = var.az_1

  tags = {
    Name = "${var.public_subnets_name}_1"
  }

}

resource "aws_subnet" "public_2" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_2
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = var.az_2

  tags = {
    Name = "${var.public_subnets_name}_2"
  }

}


resource "aws_subnet" "public_3" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_public_3
  map_public_ip_on_launch = var.map_public_ip_on_launch_public
  availability_zone       = var.az_3

  tags = {
    Name = "${var.public_subnets_name}_3"
  }

}


resource "aws_subnet" "private_1" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_1
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = var.az_1

  tags = {
    Name = "${var.private_subnets_name}_1"
  }

}


resource "aws_subnet" "private_2" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_2
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = var.az_2

  tags = {
    Name = "${var.private_subnets_name}_2"
  }

}


resource "aws_subnet" "private_3" {

  vpc_id                  = aws_vpc.wordpress_vpc.id
  cidr_block              = var.cidr_private_3
  map_public_ip_on_launch = var.map_public_ip_on_launch_private
  availability_zone       = var.az_3

  tags = {
    Name = "${var.private_subnets_name}_3"
  }

}


resource "aws_db_subnet_group" "subnet_group_private" {

  subnet_ids = ["${aws_subnet.private_1.id}", "${aws_subnet.private_2.id}", "${aws_subnet.private_3.id}"]

}

