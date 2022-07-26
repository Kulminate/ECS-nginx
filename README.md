# ECS-nginx
This repo contains simple terraform code for creating the ecs nginx container which will be hided under created load balancer.
After executing `terraform init` and `terrafrom apply` such resources will be created in eu-west-2 AWS region:
- Networking:
    - VPC
    - 2 subnets
    - Internet gateway
    - 2 security groups
    - 1 route table
- ALB and appropriate target group
- ECS service with nginx container