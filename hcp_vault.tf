// Create a Vault cluster in the same region and cloud provider as the HVN
resource "hcp_vault_cluster" "example" {
  cluster_id = "${var.environment_name}-vault-cluster"
  hvn_id     = hcp_hvn.hvn.hvn_id
  tier       = "dev"
  public_endpoint = true
}

output "hcp_vault_public_url" {
  value = hcp_vault_cluster.example.vault_public_endpoint_url
}


resource "hcp_vault_cluster_admin_token" "example" {
  cluster_id = hcp_vault_cluster.example.cluster_id
}

output "hcp_vault_cluster_admin_token" {
  value = hcp_vault_cluster_admin_token.example.token
  sensitive  = true
}


resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  aws_instance.windows.public_ip
    userdn      = "OU=Users,OU=Accounts,DC=mattygrecgrec,DC=com"
    userattr    = "sAMAccountName"
    upndomain   = var.ad_domain_name
    discoverdn  = false
    groupdn     = "OU=Groups,DC=mattygrecgrec,DC=com"
    groupfilter = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
}
