module "common-provider" {
  source = "github.com/microsoft/bedrock?ref=master//cluster/common/provider"
}

resource "null_resource" "velero_restore" {
  provisioner "local-exec" {
    command = "echo 'Need to use this var so terraform waits for kubeconfig ' ${var.kubeconfig_complete};KUBECONFIG=${var.output_directory}/${var.kubeconfig_filename} ${path.module}/velero_restore.sh -b '${var.velero_bucket}' -p '${var.velero_provider}' -s '${var.velero_secrets}' -l '${var.velero_backup_location_config}' -v '${var.velero_volume_snapshot_location_config}' -n '${var.velero_backup_name}' -r '${var.velero_restore_name}' -i '${var.velero_install}' -u '${var.velero_uninstall}' -d '${var.velero_delete_pod}'"
  }
}
