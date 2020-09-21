resource "aws_ecs_cluster" "terraform-cluster" {
  name = "terraform-cluster"
}

resource "aws_ecs_task_definition" "terraform_task" {
  family                   = "task_definition_terraform"
  network_mode             = "awsvpc"
  container_definitions    = file("task-definitions/service.json")
}

resource "aws_ecs_service" "terraform-app-service" {
  name            = "terraform-app-service"
  cluster         = aws_ecs_cluster.terraform-cluster.id
  task_definition = aws_ecs_task_definition.terraform_task.arn
  desired_count   = 1
  iam_role        = aws_iam_role.foo.arn
  depends_on      = [aws_iam_role_policy.foo]

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.foo.arn
    container_name   = "mongo"
    container_port   = 8080
  }

  placement_constraints {
    type       = "memberOf"
    expression = "attribute:ecs.availability-zone in [us-west-2a, us-west-2b]"
  }
}