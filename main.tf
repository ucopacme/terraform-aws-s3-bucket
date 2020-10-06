resource "aws_s3_bucket" "this" {
  acl           = var.acl
  bucket        = var.bucket
  count         = var.enabled ? 1 : 0
  force_destroy = var.force_destroy
  tags          = merge(var.tags, map("Name", var.bucket))
}

resource "aws_s3_bucket_public_access_block" "this" {
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  bucket                  = join("", aws_s3_bucket.this.*.id)
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}
