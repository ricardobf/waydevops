/*
  Cluster
*/
resource "aws_ecs_cluster" "terraform-cluster" {
  name = "terraform-cluster"
}

/*
  Repo for docker image
*/
resource "aws_ecr_repository" "todo_app" {
  name = var.aws_repository_name
} 

/*
  Fargate Task
*/
resource "aws_ecs_task_definition" "terraform_task" {
  family                   = "task_definition_terraform"
  network_mode             = "awsvpc"
  container_definitions    = file("task-definitions/service.json")
  requires_compatibilities = ["FARGATE"]
  cpu = "256"
  memory = "512"
  execution_role_arn = aws_iam_role.this.arn
}

/*
  Fargate Service
*/
resource "aws_ecs_service" "terraform-app-service" {
  name            = "terraform-app-service"
  cluster         = aws_ecs_cluster.terraform-cluster.id
  task_definition = aws_ecs_task_definition.terraform_task.arn
  launch_type   = "FARGATE"

  network_configuration {
    subnets          = data.aws_subnet_ids.default_subnet_ids.ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.alb_target_group.arn
    container_name   = var.aws_repository_name
    container_port   = 80
  }
  depends_on = [aws_alb.ecs-load-balancer]
}

/*
  Default VPC
*/
data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

/*
  Subnets of VPC
*/
data "aws_subnet_ids" "default_subnet_ids" {
  vpc_id = data.aws_vpc.main.id

  tags = {
    Tier = "Public"
  }
}

