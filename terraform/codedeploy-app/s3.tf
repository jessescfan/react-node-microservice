
resource "aws_s3_bucket" "deploy-bucket" {
  bucket = "jmat-microservices-${var.app-name}-deployment"
}