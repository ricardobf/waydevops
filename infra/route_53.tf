/*
  Hosted Zone (ricardobf.me)
*/
resource "aws_route53_zone" "primary" {
  name = var.aws_hosted_zone
}

/*
  Record for S3 zone
*/
resource "aws_route53_record" "S3-frontend" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.aws_hosted_zone
  type    = "A"

  alias {
    name = aws_s3_bucket.terraform_s3.website_domain
    zone_id = aws_s3_bucket.terraform_s3.hosted_zone_id
    evaluate_target_health = true
  }
}

/*
  Record for ECS
*/
resource "aws_route53_record" "ECS-backend" {
  zone_id = aws_route53_zone.primary.zone_id
  name    = var.aws_api_hosted_zone
  type    = "A"

  records = [aws_alb.ecs-load-balancer.dns_name]

  depends_on = [aws_alb.ecs-load-balancer]
}
