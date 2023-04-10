resource "ad_ou" "o" { 
    name = "top_org"
    path = "dc=mattygrecgrec,dc=com"
    description = "OU for tests"
    protected = false
}

resource "ad_group" "groupz" {
  name             = "groupz"
  sam_account_name = "GROUPZ"
  scope            = "global"
  category         = "security"
  container        = ad_ou.o.dn
}

resource "ad_user" "userz" {
  principal_name    = "userz"
  sam_account_name  = "USERZ"
  display_name      = "Terraform Test User"
  initial_password  = "Password"
  container         = ad_ou.o.dn
}

resource "ad_group_membership" "groupz_userz" {
  group_id = ad_group.groupz.id
  group_members = [
    ad_user.userz.id
  ]
}