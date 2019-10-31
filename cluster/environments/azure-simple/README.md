# azure-simple

The `azure-simple` environment is a non-production ready template we provide to easily try out Bedrock on Azure.

## Getting Started

1. Copy this template directory to a repo of its own. Bedrock environments remotely reference the Terraform modules that they need and do not need be housed in the Bedrock repo.
2. Follow the instructions on the [main Azure page](../../azure) in this repo to create your cluster and surrounding infrastructure.

## Resource Group Requirement

This environment requires a single resource group be created.  The requisite variable is `global_resource_group_name`.  To use the Azure CLI to create the resource group, see [here](../../azure/README.md).