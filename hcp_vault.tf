// Create a Vault cluster in the same region and cloud provider as the HVN
resource "hcp_vault_cluster" "example" {
  cluster_id = "${var.environment_name}-vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "dev"
  public_endpoint = true
}

output "hcp_valut_public_url" {
  value = hcp_vault_cluster.example.public_endpoint
}


resource "hcp_vault_cluster_admin_token" "example" {
  cluster_id = hcp_vault_cluster.example.cluster_id
  #sensitive  = true
}

output "hcp_vault_cluster_admin_token" {
  value = hcp_vault_cluster_admin_token.example.token
}