# Terraform AKS deploy

## Documentation

* [Azure provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
* [AKS module](https://registry.terraform.io/modules/Azure/aks/azurerm/latest)
* [Network module](https://registry.terraform.io/modules/Azure/network/azurerm/latest)
* [AKS Release version](https://docs.microsoft.com/en-US/azure/aks/supported-kubernetes-versions#azure-portal-and-cli-versions)

## Requirements

* Terraform: `>= v0.15.0`
* Configure Azure subscription
* The VPC must be exists
* The subnets must be exists
* Require `azure-cli` ([how-to-install](https://docs.microsoft.com/en-US/cli/azure/install-azure-cli))

## First steps!

1. Create Storage to save `.tfstate`
2. Modify `config.tf` with properly `subscription_id`, `storage_account_name` and `resource_group_name`
3. Modify `aks.auto.tfvars` with your values
4. Install all dependencies and providers: `terraform init`
5. Deploy: `terraform apply`

## Files

* `config.tf`: providers, requirements and backend for Terraform
* `aks.auto.tfvars`: values for deployment
* `main.tf`: main file with AKS resource
* `outputs.tf`: output resources
* `variables.tf`: declare all variables with default values

## Default values

```bash
# AKS
## GENERAL
aks_rg_name      = "my-resource-group"
aks_cluster_name = "cluster"
aks_version      = "1.19.7"
aks_nr_workers   = 3

## WORKERS
aks_worker_volume_size = 100
```

## Tests

* (Average) Complete deployment: ~10 minutes
