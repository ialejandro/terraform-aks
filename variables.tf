# AKS
## GENERAL
variable "aks_rg_name" {
  description = "Name of the Resource group"
  type        = string
}

variable "aks_cluster_name" {
  description = "Name of the AKS cluster. Also used as a prefix in names of related resources"
  type        = string
  default     = "cluster-aks"
}

variable "aks_version" {
  description = "Kubernetes version to use for the AKS cluster"
  type        = string
  default     = "1.19.7"
}

variable "aks_region" {
  description = "The region to host the cluster in"
  type        = string
  default     = "northeurope"
}

variable "aks_network_plugin" {
  description = "Network plugin to use for networking. Accepted values are: azure or kubenet"
  type        = string
  default     = "kubenet"

  validation {
    condition = (
      var.aks_network_plugin == "azure" ||
      var.aks_network_plugin == "kubenet"
    )
    error_message = "Accepted values are azure or kubenet."
  }
}

variable "aks_sku_tier" {
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid"
  type        = string
  default     = "Free"

  validation {
    condition = (
      var.aks_sku_tier == "Free" ||
      var.aks_sku_tier == "Paid"
    )
    error_message = "Accepted values are azure or kubenet."
  }
}

variable "aks_rbac_aad_admin_group_object_ids" {
  description = "Object ID of groups with admin access"
  type        = list(string)
  default     = null
}

## WORKERS
variable "aks_nr_workers" {
  description = "The number of nodes"
  type        = number
  default     = 3
}

variable "aks_worker_volume_size" {
  description = "The size disk GBs"
  type        = number
  default     = 100
}

variable "aks_agents_availability_zones" {
  description = "A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created"
  type        = list(string)
  default     = ["1", "2"]
}

## NETWORK
variable "vnet_subnet_id" {
  description = "The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created"
  type        = string
  default     = null
}

variable "network_policy" {
  description = "Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created"
  type        = string
  default     = "calico"

  validation {
    condition = (
      var.network_policy == "azure" ||
      var.network_policy == "calico"
    )
    error_message = "Accepted values are azure or calico."
  }
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created"
  type        = string
  default     = "10.0.1.10"
}

variable "docker_bridge_cidr" {
  description = "IP address (in CIDR notation) used as the Docker bridge IP address on nodes. Changing this forces a new resource to be created"
  type        = string
  default     = "172.17.0.1/16"
}

variable "service_cidr" {
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_prefixes" {
  description = "The Subnetwork Range used by the Kubernetes service"
  type        = list
  default     = ["10.0.0.0/24"]
}

variable "aks_service_cidr" {
  description = "The Network Range used by the Kubernetes service. Changing this forces a new resource to be created"
  type        = string
  default     = "10.0.1.0/24"
}
