resource "aws_ecs_cluster" "main" {
}


resource "aws_lb_listener" "http" {
load_balancer_arn = aws_lb.alb.arn
port = 80
protocol = "HTTP"


default_action {
type = "forward"
target_group_arn = aws_lb_target_group.tg.arn
}
}


resource "aws_ecs_task_definition" "app" {
family = "yellow-pages-task"
network_mode = "awsvpc"
requires_compatibilities = ["FARGATE"]
cpu = "256"
memory = "512"
execution_role_arn = aws_iam_role.ecs_task_execution.arn


container_definitions = jsonencode([
{
name = "yellow-pages-app"
image = var.container_image
portMappings = [
{
containerPort = 80
hostPort = 80
}
]
}
])
}


resource "aws_ecs_service" "app" {
name = "yellow-pages-service"
cluster = aws_ecs_cluster.main.id
task_definition = aws_ecs_task_definition.app.arn
desired_count = 1
launch_type = "FARGATE"


network_configuration {
subnets = var.public_subnet_ids
security_groups = [aws_security_group.ecs_sg.id]
assign_public_ip = true
}


load_balancer {
target_group_arn = aws_lb_target_group.tg.arn
container_name = "yellow-pages-app"
container_port = 80
}
depends_on = [aws_lb_listener.http]
}


resource "aws_iam_role" "ecs_task_execution" {
name = "ecsTaskExecutionRole"


assume_role_policy = jsonencode({
Version = "2012-10-17",
Statement = [
{
Action = "sts:AssumeRole",
Effect = "Allow",
Principal = {
Service = "ecs-tasks.amazonaws.com"
}
}
]
})
}


resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
role = aws_iam_role.ecs_task_execution.name
policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}