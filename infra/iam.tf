/*
  IAM Role
*/
resource "aws_iam_role" "this" {
  name = "ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.this.json
}

/*
  IAM Role Policy
*/
data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs.amazonaws.com",
      ]
    }
  }
}

/*
  IAM Role Policy
*/
resource "aws_iam_role_policy_attachment" "this" {
  role = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}