resource "aws_s3_bucket" "classifieds-app" {
  bucket = "jmat-microservices-classifieds-app"
  acl = "public-read"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicRead",
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:getObject"
      ],
      "Resource": [
        "arn:aws:s3:::jmat-microservices-classifieds-app/*"
      ]
    }
  ]
}
POLICY

  website {
    index_document = "index.html"
  }
}