output "gatewayurl" {
  value = "${lookup(azurerm_template_deployment.api_mgmt_deployment.outputs, "gatewayurl")}"
}
