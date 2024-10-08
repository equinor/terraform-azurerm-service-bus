resource "random_id" "name_suffix" {
  byte_length = 8
}

resource "random_uuid" "subscription_id" {}

locals {
  name_suffix         = random_id.name_suffix.hex
  subscription_id     = random_uuid.subscription_id.result
  resource_group_name = "rg-${local.name_suffix}"
}
