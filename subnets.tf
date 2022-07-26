resource "aws_subnet" "ecs-1" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "ecs-1"
  }
}

resource "aws_subnet" "ecs-2" {
  vpc_id     = aws_vpc.main-vpc.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "ecs-2"
  }
}