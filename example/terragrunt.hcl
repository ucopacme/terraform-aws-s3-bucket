inputs = {
  bucket        = join("-", [local.application, local.environment, "bucket"])
  enabled       = true
  policy        = local.policy
  sse_algorithm = "aws:kms"
  tags = {
    "ucop:application" = local.application
    "ucop:createdBy"   = local.createdBy
    "ucop:environment" = local.environment
    "ucop:group"       = local.group
    "ucop:source"      = local.source
  }
  versioning_enabled = true
}

locals {
  application = "wheres-my-super-suit"
  createdBy   = "edna.mode@incredibl.es"
  environment = "prod"
  group       = "incredibles"
  policy      = jsondecode(file("./policy.json"))
  source      = "https://github.com/ucopacme/terraform-aws-vpn.git"
}

terraform {
  source = "./.."
}
