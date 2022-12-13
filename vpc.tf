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


