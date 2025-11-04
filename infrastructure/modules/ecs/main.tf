resource "aws_ecs_cluster" "main" {
name = var.cluster_name
}


resource "aws_security_group" "ecs_sg" {
vpc_id = var.vpc_id
ingress {
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}
}


resource "aws_lb" "alb" {
name = var.alb_name
internal = false
load_balancer_type = "application"
subnets = var.public_subnet_ids
}