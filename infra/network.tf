/*
  Security Group - External
*/
resource "aws_security_group" "alb_external" {
  name        = "aws_sec_group_external"
  description = "Allow 80 and 443 port inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "aws_sec_group",
    Environment = "${terraform.workspace}"
  }
}

/*
  Security Group - Internal
*/
resource "aws_security_group" "allow_internal" {
  name        = "aws_sec_group_internal"
  description = "Allow all port inbound traffic"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol  = "-1"
    self = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "aws_sec_group_internal",
    Environment = "${terraform.workspace}"
  }
}

/*
  ECS Listener
*/
resource "aws_alb_listener" "ecs-alb-listener" {
  load_balancer_arn = aws_alb.ecs-load-balancer.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_alb_target_group.alb_target_group.id
    type             = "forward"
  }
}

# resource "aws_subnet" "us-west-2a-public" {
#   vpc_id = aws_vpc.main.id
#   cidr_block        = "172.31.32.0/20"
# #   availability_zone = "${data.aws_availability_zones.available.names[1]}"
#   depends_on        = [aws_vpc.main]
#   tags = {
#     Name        = "Subnet 2a",
#     Environment = "${terraform.workspace}"
#   }
# }

# resource "aws_subnet" "us-west-2c-public" {
#   vpc_id = aws_vpc.main.id
#   cidr_block = "172.31.0.0/20"
#   depends_on        = [aws_vpc.main]
#   tags = {
#     Name        = "Subnet 2c",
#     Environment = "${terraform.workspace}"
#   }
# }
