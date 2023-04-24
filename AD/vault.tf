resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  "ldap://${var.ad_controller_public_ip}"
    request_timeout = 30
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