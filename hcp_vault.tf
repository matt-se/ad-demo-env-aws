// Create a Vault cluster in the same region and cloud provider as the HVN
resource "hcp_vault_cluster" "example" {
  cluster_id = "${var.environment_name}-vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "dev"
  public_endpoint = true
}

output "hcp_vault_public_url" {
  value = hcp_vault_cluster.example.public_endpoint
}


resource "hcp_vault_cluster_admin_token" "example" {
  cluster_id = hcp_vault_cluster.example.cluster_id
}

output "hcp_vault_cluster_admin_token" {
  value = hcp_vault_cluster_admin_token.example.token
  sensitive  = true
}

/*
resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  aws_directory_service_directory.ad.access_url
    userdn      = "OU=Users,OU=Accounts,DC=example,DC=org"
    userattr    = "sAMAccountName"
    upndomain   = "EXAMPLE.ORG"
    discoverdn  = false
    groupdn     = "OU=Groups,DC=example,DC=org"
    groupfilter = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
}*/


resource "vault_namespace" "dummy" {
  path = "dummy"
}