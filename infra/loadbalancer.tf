/*
  Application Load Balancer
*/
resource "aws_alb" "ecs-load-balancer" {
  name               = "ecs-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups = ["${aws_security_group.alb_external.id}", "${aws_security_group.allow_internal.id}"]
  # security_groups    = [aws_security_group.lb_sg.id]
  # subnets            = [aws_subnet.us-west-2a-public.id, aws_subnet.us-west-2c-public.id]

  enable_deletion_protection = true

  # access_logs {
  #   bucket  = aws_s3_bucket.lb_logs.bucket
  #   prefix  = "test-lb"
  #   enabled = true
  # }

  tags = {
    Environment = "production"
  }
}


/*
  Application Load Balancer Target Group
*/
resource "aws_alb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = data.aws_vpc.main.id
  depends_on = [aws_alb.ecs-load-balancer]
}

# resource "aws_vpc" "main" {
#   cidr_block = "172.31.0.0/16"
# }
