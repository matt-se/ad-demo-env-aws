resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  "ldap://${var.ad_controller_public_ip}"
    insecure_tls = true
    description = "LDAP auth backend for ${var.ad_domain}.com"

    binddn      = "CN=Administrator,CN=Users,DC=${var.ad_domain},DC=com"
    bindpass    = var.windows_password
    userdn      = "OU=Users,DC=${var.ad_domain},DC=com"
    userattr    = "sAMAccountName"
    userfilter  = "(objectClass=person)"
    
    #upndomain   = "${var.ad_domain}.com"
    #discoverdn  = true
    #groupdn     = "OU=Groups,DC=${var.ad_domain},DC=com"
    #groupfilter = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
    
}