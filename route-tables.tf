resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecs-gw.id
  }

  tags = {
    "Name" = "public"
  }
}

resource "aws_route_table_association" "ecs-1" {
  subnet_id      = aws_subnet.ecs-1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "ecs-2" {
  subnet_id      = aws_subnet.ecs-2.id
  route_table_id = aws_route_table.public_route.id
}