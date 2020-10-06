inputs = {
  bucket        = join("-", [local.application, local.environment, "bucket"])
  enabled       = true
  sse_algorithm = "aws:kms"
  tags = {
    "ucop:application" = local.application
    "ucop:createdBy"   = local.createdBy
    "ucop:environment" = local.environment
    "ucop:group"       = local.group
    "ucop:source"      = local.source
  }
  #  statement          = {}
  versioning_enabled = true
}

locals {
  application = "david"
  createdBy   = "edna.mode@incredibl.es"
  environment = "prod"
  group       = "chs"
  source      = "https://github.com/ucopacme/terraform-aws-vpn.git"
}

terraform {
  source = "./.."
}
