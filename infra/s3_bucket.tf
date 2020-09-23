/*
  S3 Bucket for frontend
*/
resource "aws_s3_bucket" "terraform_s3" {
  bucket = var.aws_hosted_zone
  acl    = "public-read"
  policy = file("s3_policy.json")

  website {
    index_document = "index.html"
    error_document = "error.html"

    routing_rules = <<EOF
[{
    "Condition": {
        "KeyPrefixEquals": "build/"
    },
    "Redirect": {
        "ReplaceKeyPrefixWith": "/"
    }
}]
EOF
  }
}