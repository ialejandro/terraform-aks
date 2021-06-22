output "aks_cluster_id" {
  value = module.aks.aks_id
}

output "aks_kubeconfig" {
  value     = module.aks.kube_config_raw
  sensitive = true
}

output "aks_rg" {
  value = azurerm_resource_group.aks_rg.name
}