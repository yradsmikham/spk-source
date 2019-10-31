#--------------------------------------------------------------
# Cluster common
#--------------------------------------------------------------

agent_vm_count = "3"

agent_vm_size = ""

cluster_name = "spincluster"

dns_prefix = "spindns"

keyvault_name = ""

keyvault_resource_group = ""

service_principal_id = ""

service_principal_secret = ""

ssh_public_key = ""

#--------------------------------------------------------------
# Flux gitops common
#--------------------------------------------------------------
gitops_ssh_url = "git@github.com:sarath-p/vote-flux.git"

gitops_ssh_key = ""

#--------------------------------------------------------------
# Traffic Manager
#--------------------------------------------------------------
traffic_manager_profile_name = ""

traffic_manager_dns_name = ""

traffic_manager_resource_group_name = ""


#--------------------------------------------------------------
# West
#--------------------------------------------------------------
west_resource_group_name = ""

gitops_west_path = ""

#--------------------------------------------------------------
# East
#--------------------------------------------------------------
east_resource_group_name = ""

gitops_east_path = ""

#--------------------------------------------------------------
# Central
#--------------------------------------------------------------
central_resource_group_name = ""

gitops_central_path = ""

#--------------------------------------------------------------
# Optional variables - Uncomment to use
#--------------------------------------------------------------
# gitops_central_url_branch = "master"
# gitops_east_url_branch = "master"
# gitops_west_url_branch = "master"
# gitops_poll_interval = "30s"
# oms_agent_enabled = "false"
