## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| aws | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| abort\_incomplete\_multipart\_upload\_days | Maximum time (in days) that you want to allow multipart uploads to remain in progress | `number` | `5` | no |
| allow\_encrypted\_uploads\_only | Set to `true` to prevent uploads of unencrypted objects to S3 bucket | `bool` | `false` | no |
| allowed\_bucket\_actions | List of actions the user is permitted to perform on the S3 bucket | `list(string)` | <pre>[<br>  "s3:PutObject",<br>  "s3:PutObjectAcl",<br>  "s3:GetObject",<br>  "s3:DeleteObject",<br>  "s3:ListBucket",<br>  "s3:ListBucketMultipartUploads",<br>  "s3:GetBucketLocation",<br>  "s3:AbortMultipartUpload"<br>]</pre> | no |
| block\_public\_acls | Set to `false` to disable the blocking of new public access lists on the bucket | `bool` | `true` | no |
| block\_public\_policy | Set to `false` to disable the blocking of new public policies on the bucket | `bool` | `true` | no |
| bucket | S3 Bucket name | `string` | n/a | yes |
| cors\_rule\_inputs | Specifies the allowed headers, methods, origins and exposed headers when using CORS on this bucket | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `null` | no |
| enable\_glacier\_transition | Enables the transition to AWS Glacier which can cause unnecessary costs for huge amount of small files | `bool` | `true` | no |
| enable\_standard\_ia\_transition | Enables the transition to STANDARD\_IA | `bool` | `false` | no |
| enabled | Set to `false` to prevent the module from creating resources | `bool` | `true` | no |
| expiration\_days | Number of days after which to expunge the objects | `number` | `90` | no |
| force\_destroy | A boolean string that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable | `bool` | `false` | no |
| glacier\_transition\_days | Number of days after which to move the data to the glacier storage tier | `number` | `60` | no |
| ignore\_public\_acls | Set to `false` to disable the ignoring of public access lists on the bucket | `bool` | `true` | no |
| kms\_master\_key\_arn | The AWS KMS master key ARN used for the `SSE-KMS` encryption. This can only be used when you set the value of `sse_algorithm` as `aws:kms`. The default aws/s3 AWS KMS master key is used if this element is absent while the `sse_algorithm` is `aws:kms` | `string` | `""` | no |
| lifecycle\_rule\_enabled | Enable or disable lifecycle rule | `bool` | `false` | no |
| lifecycle\_tags | Tags filter. Used to manage object lifecycle events | `map(string)` | `{}` | no |
| noncurrent\_version\_expiration\_days | Specifies when noncurrent object versions expire | `number` | `90` | no |
| noncurrent\_version\_transition\_days | Number of days to persist in the standard storage tier before moving to the glacier tier infrequent access tier | `number` | `30` | no |
| policy | A valid bucket policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy | `string` | `""` | no |
| prefix | Prefix identifying one or more objects to which the rule applies | `string` | `""` | no |
| restrict\_public\_buckets | Set to `false` to disable the restricting of making the bucket public | `bool` | `true` | no |
| sse\_algorithm | The server-side encryption algorithm to use. Valid values are `AES256` and `aws:kms` | `string` | `"AES256"` | no |
| standard\_transition\_days | Number of days to persist in the standard storage tier before moving to the infrequent access tier | `number` | `30` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| user\_enabled | Set to `true` to create an IAM user with permission to access the bucket | `bool` | `false` | no |
| versioning\_enabled | A state of versioning. Versioning is a means of keeping multiple variants of an object in the same bucket | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket\_arn | Bucket ARN |
| bucket\_id | Bucket ID |
| bucket\_name | Bucket Name |
| bucket\_regional\_name | The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL. |
| hosted\_zone\_id | The Route 53 Hosted Zone ID for this bucket's region. |
| website\_domain | The domain of the website endpoint, if the bucket is configured with a website. If not, this will be an empty string. This is used to create Route 53 alias records. |
| website\_endpoint | The website endpoint, if the bucket is configured with a website. If not, this will be an empty string. |
