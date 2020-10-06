output "bucket_name" {
  value       = aws_s3_bucket.this.*.bucket_domain_name
  description = "Bucket Name"
}
output "bucket_id" {
  value       = aws_s3_bucket.this.*.id
  description = "Bucket ID"
}
output "bucket_arn" {
  value       = aws_s3_bucket.this.*.arn
  description = "Bucket ARN"
}
