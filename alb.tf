resource "aws_lb_target_group" "for_nginx" {
  name     = "nginx-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = aws_vpc.main-vpc.id
    
  health_check {
    healthy_threshold = "3"
    interval = "30"
    protocol = "HTTP"
    matcher = "200"
    timeout = "20"
    path = "/"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb" "alb-for-nginx" {
  name               = "alb-for-nginx"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_port80.id]
  subnets            = [aws_subnet.ecs-1.id, aws_subnet.ecs-2.id]

  enable_deletion_protection = true

  tags = {
    Name = "alb-for-nginx"
  }
}

resource "aws_lb_listener" "nginx-ecs" {
  load_balancer_arn = aws_lb.alb-for-nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.for_nginx.arn
  }
}

output "nginx_dns_lb" {
  description = "DNS load balancer"
  value = aws_lb.alb-for-nginx.dns_name
}