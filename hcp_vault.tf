// Create a Vault cluster in the same region and cloud provider as the HVN
resource "hcp_vault_cluster" "example" {
  cluster_id = "${var.environment_name}-vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
}