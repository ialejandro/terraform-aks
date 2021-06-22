module "network" {
  source              = "Azure/network/azurerm"
  vnet_name           = "${var.aks_cluster_name}-aks-vnet"
  resource_group_name = azurerm_resource_group.aks_rg.name
  address_space       = var.service_cidr
  subnet_prefixes     = var.subnet_prefixes

  depends_on = [azurerm_resource_group.aks_rg]
}

resource "azurerm_resource_group" "aks_rg" {
  name     = var.aks_rg_name
  location = var.aks_region
}

module "aks" {
  source                          = "Azure/aks/azurerm"
  resource_group_name             = azurerm_resource_group.aks_rg.name
  prefix                          = var.aks_cluster_name
  kubernetes_version              = var.aks_version
  orchestrator_version            = var.aks_version
  sku_tier                        = var.aks_sku_tier
  network_plugin                  = var.aks_network_plugin
  vnet_subnet_id                  = module.network.vnet_subnets[0]
  private_cluster_enabled         = false
  enable_http_application_routing = false
  enable_azure_policy             = false

  # NETWORK
  network_policy                 = var.network_policy
  net_profile_dns_service_ip     = var.dns_service_ip
  net_profile_docker_bridge_cidr = var.docker_bridge_cidr
  net_profile_service_cidr       = var.aks_service_cidr


  # WORKERS
  enable_auto_scaling       = false
  agents_min_count          = var.aks_nr_workers
  agents_max_count          = var.aks_nr_workers
  agents_count              = var.aks_nr_workers
  os_disk_size_gb           = var.aks_worker_volume_size
  agents_max_pods           = 100
  agents_pool_name          = "exnodepool"
  agents_availability_zones = var.aks_agents_availability_zones
  agents_type               = "VirtualMachineScaleSets"

  agents_labels = {
    "nodepool" : "defaultnodepool"
  }

  agents_tags = {
    "agent" : "defaultnodepoolagent"
  }

  tags = {
    iac = "terraform"
  }

  depends_on = [module.network]
}

resource "local_file" "kubeconfig" {
  content  = module.aks.kube_config_raw
  filename = pathexpand("~/.kube/kubeconfig-${var.aks_cluster_name}")
}
