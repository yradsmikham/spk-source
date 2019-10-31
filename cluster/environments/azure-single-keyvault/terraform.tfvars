
#--------------------------------------------------------------
# keyvault, vnet, and subnets are created seperately by azure-common-infra
#--------------------------------------------------------------
keyvault_name = "my-keyvault"
keyvault_resource_group = "my-global-rg"

address_space = "<cidr for cluster address space>"
subnet_prefixes = "10.39.0.0/16"

subnet_name = "<subnet name>"
vnet_name = "<vnet name>"

#--------------------------------------------------------------
# Cluster variables
#--------------------------------------------------------------
agent_vm_count = "3"
agent_vm_size = "Standard_D4s_v3"

cluster_name = "azure-single-keyvault"
dns_prefix = "azure-single-keyvault"

gitops_ssh_url = "git@github.com:Microsoft/fabrikate-production-cluster-demo-materialized"
gitops_ssh_key = "/full/path/to/gitops_repo_private_key"

resource_group_name = "azure-single-keyvault-rg"

ssh_public_key = "<ssh public key>"

service_principal_id = "<service principal id>"
service_principal_secret = "<service principal secret>"

#--------------------------------------------------------------
# Optional variables - Uncomment to use
#--------------------------------------------------------------
# gitops_url_branch = "release-123"
# gitops_poll_interval = "30s"
# gitops_path = "prod"
# oms_agent_enabled = "false"
# enable_acr = "true"
# acr_name = <name of container registry>
