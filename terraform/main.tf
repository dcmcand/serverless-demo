terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "infrastructure"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "inbound_bucket" {
    bucket = "adhoc-serverless-demo-inbound-bucket"
    acl = "private"
    tags = {
        project = "Serverless Demo"
    }
  
}

resource "aws_s3_bucket" "outbound_bucket" {
    bucket = "adhoc-serverless-demo-outbound-bucket"
    acl = "private"
    tags = {
        project = "Serverless Demo"
    }
  
}

resource "aws_iam_role" "inbound_bucket_policy" {
    name = "adhoc-serverless-demo-inbound-bucket-policy"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
    })
    inline_policy {
      name = "adhoc-serverless-demo-inbound-bucket-policy"
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
          {
            Effect = "Allow",
            Action = ["s3:ListBucket"],
            Resource = [aws_s3_bucket.inbound_bucket.arn]
          },
          {
            Effect = "Allow",
            Action = [
              "s3:GetObject",
              "s3:DeleteObject"
            ],
            Resource = ["${aws_s3_bucket.inbound_bucket.arn}/*"]
          }
        ]
      })
      
    }
    tags = {
        project = "Serverless Demo"
    }
}
resource "aws_iam_role" "outbound_bucket_role" {
    name = "adhoc-serverless-demo-outbound-bucket-policy"
    assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid = ""
          Principal = {
            Service = "lambda.amazonaws.com"
          }
        },
      ]
    })
    inline_policy {
      name = "adhoc_serverless_demo_outbound_bucket_policy"
      policy = jsonencode({
        Version = "2012-10-17",
        Statement = [
            {
            Effect = "Allow"
            Action = ["s3:ListBucket"]
            Resource = [aws_s3_bucket.outbound_bucket.arn]
            },
            {
            Effect = "Allow"
            Action = [
                "s3:PutObject"
            ]
            Resource = ["${aws_s3_bucket.outbound_bucket.arn}/*"]
            }
        ]
        })
    }
    tags = {
        project = "Serverless Demo"
    }
}

output "inbound_bucket_name" {
    value = aws_s3_bucket.inbound_bucket.bucket
}
output "outbound_bucket_name" {
    value = aws_s3_bucket.outbound_bucket.bucket
}
output "inbound_bucket_policy_arn" {
    value = aws_iam_role.inbound_bucket_policy.arn
}
output "outbound_bucket_policy_arn" {
    value = aws_iam_role.outbound_bucket_role.arn
}