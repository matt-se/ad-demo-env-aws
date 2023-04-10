resource "ad_ou" "o" { 
    name = "top_org"
    path = "dc=mattygrecgrec,dc=com"
    description = "OU for tests"
    protected = false
}

resource "ad_group" "groupz" {
  name             = "var.name"
  sam_account_name = var.sam_account_name
  scope            = "global"
  category         = "security"
  container        = ad_ou.o.dn
}