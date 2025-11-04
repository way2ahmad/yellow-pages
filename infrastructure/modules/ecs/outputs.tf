output "alb_dns" {
value = aws_lb.alb.dns_name
}


output "ecs_security_group_id" {
value = aws_security_group.ecs_sg.id
}