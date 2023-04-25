### mount the LDAP auth backend
resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  "ldap://${var.ad_controller_public_ip}"
    starttls = false
    case_sensitive_names = false
    insecure_tls = false
    description = "LDAP auth backend for ${var.ad_domain}.com"

    binddn      = "CN=Administrator,CN=Users,DC=${var.ad_domain},DC=com"
    bindpass    = var.windows_password
    userdn      = "CN=Users,DC=${var.ad_domain},DC=com"
    userattr    = "cn"
    userfilter  = "({{.UserAttr}}={{.Username}})"
    
    upndomain   = "${var.ad_domain}.com"
    discoverdn  = false
    groupdn     = "CN=Users,DC=${var.ad_domain},DC=com"
    groupfilter = "(&(objectClass=person)(uid={{.Username}}))"
    groupattr   = "memberOf"
    deny_null_bind = true


    token_policies = ["default"]
}

### Create a group in this LDAP auth mount.  Any user who is a member of this group in AD will be added to this group when they log into Vault and will inherit the policies of this group.
resource "vault_ldap_auth_backend_group" "z" {
    # Because we're using memberOf, this should be the full DN of the group.
    groupname = "cn=groupz,cn=users,dc=mattygrecgrec,dc=com"
    policies  = ["groupz_kv_secrets"]
    backend   = vault_ldap_auth_backend.ldap.path
}


### Create a custom kv2 secret mount for groupz
resource "vault_mount" "kv2_for_groupz" {
  path        = "groupz_kv_secrets"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount for AD security group groupz"
}

resource "vault_kv_secret_backend_v2" "example" {
  mount                = vault_mount.kv2_for_groupz.path
  max_versions         = 5
  delete_version_after = 12600
  cas_required         = false
}

resource "vault_kv_secret_v2" "example" {
  mount                      = vault_mount.kv2_for_groupz.path
  name                       = "secret"
  cas                        = 1
  delete_all_versions        = true
  data_json                  = jsonencode(
  {
    zip       = "zap",
    foo       = "bar"
  }
  )
}

### Create the policy that allows members of groupz to access the kv path
resource "vault_policy" "groupz_kv_secrets" {
  name = "groupz_kv_secrets"

  policy = <<EOT
path "groupz_kv_secrets/*" {
  capabilities = ["create", "read", "update", "patch", "delete", "list"]
}
EOT
}
