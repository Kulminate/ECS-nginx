resource "aws_vpc" "main-vpc" {
  cidr_block = "10.0.0.0/16"
    tags = {
    Name = "main-vpc"
  }
}


resource "aws_internet_gateway" "ecs-gw" {
  vpc_id = aws_vpc.main-vpc.id
  tags = {
    Name = "main-vpc"
  }
}