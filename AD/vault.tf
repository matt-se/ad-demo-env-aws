resource "vault_ldap_auth_backend" "ldap" {
    path        = "ldap"
    url         =  var.ad_controller_public_ip
    userdn      = "OU=Users,OU=Accounts,DC=${var.ad_domain},DC=com"
    userattr    = "sAMAccountName"
    upndomain   = "${var.ad_domain}.com"
    discoverdn  = false
    groupdn     = "OU=Groups,DC=${var.ad_domain},DC=com"
    groupfilter = "(&(objectClass=group)(member:1.2.840.113556.1.4.1941:={{.UserDN}}))"
}