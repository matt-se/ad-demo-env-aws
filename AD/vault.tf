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