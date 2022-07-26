resource "aws_security_group" "allow_port80" {
  name        = "allow_port80"
  description = "Allow port 80 for alb access"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description      = "Allow port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_port80"
  }
}

resource "aws_security_group" "allow_alb_connection" {
  name        = "allow_alb_connection"
  description = "Allow connection from alb to ecs"
  vpc_id      = aws_vpc.main-vpc.id

  ingress {
    description      = "Allow connection"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_groups  = [aws_security_group.allow_port80.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "nginx-alb"
  }
}