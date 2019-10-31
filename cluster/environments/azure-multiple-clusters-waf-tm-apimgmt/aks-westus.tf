data "azurerm_resource_group" "westrg" {
  name     = "${var.west_resource_group_name}"
}

# local variable with cluster and location specific
locals {
  west_rg_name                 = "${data.azurerm_resource_group.westrg.name}"
  west_rg_location             = "${data.azurerm_resource_group.westrg.location}"
  west_prefix                  = "${local.west_rg_location}-${var.cluster_name}"
  west_flux_clone_dir          = "${local.west_prefix}-flux"
  west_kubeconfig_filename     = "${local.west_prefix}_kube_config"
  west_ip_address_out_filename = "${local.west_prefix}_ip_address"
}

# Creates vnet
module "west_vnet" {
  source = "github.com/microsoft/bedrock?ref=master//cluster/azure/vnet"

  resource_group_name     = "${local.west_rg_name}"
  subnet_names = ["${var.cluster_name}-aks-subnet"]
  address_space   = "${var.west_address_space}"
  subnet_prefixes = "${var.west_subnet_prefixes}"

  tags = {
    environment = "azure-multiple-clusters"
  }
}

# Creates aks cluster
module "west_aks" {
  source = "github.com/microsoft/bedrock?ref=master//cluster/azure/aks"

  resource_group_name      = "${local.west_rg_name}"
  cluster_name             = "${var.cluster_name}-west"
  agent_vm_count           = "${var.agent_vm_count}"
  dns_prefix               = "${var.dns_prefix}"
  vnet_subnet_id           = "${module.west_vnet.vnet_subnet_ids[0]}"
  service_cidr             = "${var.west_service_cidr}"
  dns_ip                   = "${var.west_dns_ip}"
  docker_cidr              = "${var.west_docker_cidr}"
  ssh_public_key           = "${var.ssh_public_key}"
  service_principal_id     = "${var.service_principal_id}"
  service_principal_secret = "${var.service_principal_secret}"
  kubeconfig_recreate      = ""
  kubeconfig_filename      = "${local.west_kubeconfig_filename}"
  oms_agent_enabled        = "${var.oms_agent_enabled}"
}

# Deploys flux in aks cluster
module "west_flux" {
  source = "github.com/microsoft/bedrock?ref=master//cluster/common/flux"

  gitops_ssh_url       = "${var.gitops_ssh_url}"
  gitops_ssh_key       = "${var.gitops_ssh_key}"
  flux_recreate        = "${var.flux_recreate}"
  kubeconfig_complete  = "${module.west_aks.kubeconfig_done}"
  kubeconfig_filename  = "${local.west_kubeconfig_filename}"
  flux_clone_dir       = "${local.west_flux_clone_dir}"
  gitops_path          = "${var.gitops_west_path}"
  gitops_poll_interval = "${var.gitops_poll_interval}"
}

# create a dynamic public ip and associate with traffic manger endpoint

module "west_tm_endpoint" {
  source = "github.com/microsoft/bedrock?ref=master//cluster/azure/tm-endpoint-ip"

  resource_group_name                 = "${local.west_rg_name}"
  traffic_manager_resource_group_name = "${var.traffic_manager_resource_group_name}"
  traffic_manager_profile_name        = "${var.traffic_manager_profile_name}"
  endpoint_name                       = "${local.west_rg_location}-waf-ipwest"
  public_ip_name                      = "${var.cluster_name}-waf-ipwest"
  ip_address_out_filename             = "${local.west_ip_address_out_filename}"
  allocation_method                   = "Dynamic"

  tags = {
    environment = "azure-multiple-clusters-waf-tm-apimgmt west- ${var.cluster_name} - public ip"
  }
}

resource "azurerm_role_assignment" "west_spra" {
  count                = "${var.service_principal_is_owner == "1" ? 1 : 0}"
  principal_id         = "${data.azuread_service_principal.sp.id}"
  role_definition_name = "${var.aks_client_role_assignment_role}"
  scope                = "${data.azurerm_resource_group.westrg.id}"
}
