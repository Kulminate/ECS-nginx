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

Also we will see `nginx_dns_lb` value which will contain our load balancers dns name through which we can connect to our nginx container. 

## Repo structure
Inside this repo we have 7 seperated terraform configuration files:
 1. `terraform.tf`:
    Inside this file we have our aws provider configuration. Currently we have there only region value, but, it would be better to also specify the backend section after s3 creation.
 2. `alb.tf`:
    This file contains our main alb configuration with listener and also with terager group configruation.
 3. `ecs.tf`:
    This file contains ecs task-definition, cluster and service configuration. For this example I used nginx:alpine image and FARGATE as the capacity provider.
 4. `route-tables.tf`:
    This file contains route table which routes to the internet gateway when we need to face the internet and also assosiation configruation in order to assosiate our route table with our subnets.
 5. `security-groups.tf`:
    This file contains two security groups: first security group allows traffic from anywhere to port 80, this security group will be used by our alb; second security group allows traffic from the first security group to port 80, this sg will be used our ecs in order to communicate with our alb internally.
 6. `subnets.tf`:
    This file contains our 2 subnets main configuration. First subnet will use 10.0.1.0/24 CIDR, second will use 10.0.2.0/24 CIDR
 7. `vps-internet-gateway.tf`:
    This file contains our VPC and internet-gateway configuration. Our VPC will have 10.0.0.0/16 CIDR.
     