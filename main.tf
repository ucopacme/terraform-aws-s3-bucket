resource "aws_s3_bucket" "this" {
  acl           = var.acl
  bucket        = var.bucket
  count         = var.enabled ? 1 : 0
  force_destroy = var.force_destroy
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn
      }
    }
  }
  tags = merge(var.tags, map("Name", var.bucket))
  versioning {
    enabled = var.versioning_enabled
  }
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSLogDeliveryAclCheck",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.bucket}"
        },
        {
            "Sid": "AWSLogDeliveryWrite",
            "Effect": "Allow",
            "Principal": {
                "Service": "delivery.logs.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": [
                "arn:aws:s3:::${var.bucket}/*"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
 }
EOF
}

resource "aws_s3_bucket_public_access_block" "this" {
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  bucket                  = join("", aws_s3_bucket.this.*.id)
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
