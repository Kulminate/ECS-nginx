resource "aws_ecs_task_definition" "ecs-nginx" {
  family = "service"
  requires_compatibilities = ["FARGATE"]
  cpu = 256
  memory = 1024
  network_mode = "awsvpc"
  container_definitions = jsonencode([
    {
      name      = "ecs-nginx"
      image     = "nginx:alpine"
      cpu       = 10
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 80
          protocol = "tcp"
        }
      ]
    }
  ])
}

resource "aws_ecs_cluster" "ecs-nginx" {
  name = "ecs-nginx"
  
}

resource "aws_ecs_cluster_capacity_providers" "ecs-nginx-provider" {
  cluster_name = aws_ecs_cluster.ecs-nginx.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_ecs_service" "nginx" {
  name            = "ecs-nginx"
  cluster         = aws_ecs_cluster.ecs-nginx.id
  task_definition = aws_ecs_task_definition.ecs-nginx.arn
  desired_count   = 1

  load_balancer {
    target_group_arn = aws_lb_target_group.for_nginx.arn
    container_name   = "ecs-nginx"
    container_port   = 80
  }

  network_configuration {
    subnets = [aws_subnet.ecs-1.id, aws_subnet.ecs-2.id]
    security_groups = [aws_security_group.allow_alb_connection.id]
    assign_public_ip = true
  }
}