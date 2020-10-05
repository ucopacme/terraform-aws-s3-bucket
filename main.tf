resource "aws_s3_bucket" "this" {
#  count         = module.this.enabled ? 1 : 0
  count      = var.enabled ? 1 : 0
  #bucket        = module.this.id
  bucket        = var.bucket
  acl           = try(length(var.grants), 0) == 0 ? var.acl : null
  force_destroy = var.force_destroy
  policy        = var.policy
  tags       = merge(var.tags, map("Name", var.name))

  versioning {
    enabled = var.versioning_enabled
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_this {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn
      }
    }
  }

  }

data "aws_partition" "current" {}

data "aws_iam_policy_document" "bucket_policy" {
  count = module.this.enabled && var.allow_encrypted_uploads_only ? 1 : 0

  statement {
    sid       = "DenyIncorrectEncryptionHeader"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:${data.aws_partition.current.partition}:s3:::${join("", aws_s3_bucket.this.*.id)}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "StringNotEquals"
      values   = [var.sse_algorithm]
      variable = "s3:x-amz-server-side-encryption"
    }
  }

  statement {
    sid       = "DenyUnEncryptedObjectUploads"
    effect    = "Deny"
    actions   = ["s3:PutObject"]
    resources = ["arn:${data.aws_partition.current.partition}:s3:::${join("", aws_s3_bucket.this.*.id)}/*"]

    principals {
      identifiers = ["*"]
      type        = "*"
    }

    condition {
      test     = "Null"
      values   = ["true"]
      variable = "s3:x-amz-server-side-encryption"
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count      = module.this.enabled && var.allow_encrypted_uploads_only ? 1 : 0
  bucket     = join("", aws_s3_bucket.this.*.id)
  policy     = join("", data.aws_iam_policy_document.bucket_policy.*.json)
  depends_on = [aws_s3_bucket_public_access_block.this]
}

resource "aws_s3_bucket_public_access_block" "this" {
  count  = module.this.enabled ? 1 : 0
  bucket = join("", aws_s3_bucket.this.*.id)

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}