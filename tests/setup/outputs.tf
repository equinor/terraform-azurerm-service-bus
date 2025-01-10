output "namespace_name" {
  value = "sbns-${local.name_suffix}"
}

output "resource_group_name" {
  value = local.resource_group_name
}

output "location" {
  value = "northeurope"
}

output "log_analytics_workspace_id" {
  value = "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.OperationalInsights/workspaces/log-${local.name_suffix}"
}

output "subnet_ids" {
  value = [
    "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/vnet-${local.name_suffix}/subnets/snet-${local.name_suffix}-01",
    "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/vnet-${local.name_suffix}/subnets/snet-${local.name_suffix}-02",
    "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.Network/virtualNetworks/vnet-${local.name_suffix}/subnets/snet-${local.name_suffix}-03"
  ]
}

output "user_assigned_identity_id" {
  value = "/subscriptions/${local.subscription_id}/resourceGroups/${local.resource_group_name}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/id-${local.name_suffix}"
}
