
resource "ad_ou" "o" { 
    name = "top_org"
    path = "dc=${var.ad_domain},dc=com"
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

resource "ad_group" "groupy" {
  name             = "groupy"
  sam_account_name = "GROUPY"
  scope            = "global"
  category         = "security"
  container        = ad_ou.o.dn
}


resource "ad_user" "userz" {
  principal_name    = "matt"
  sam_account_name  = "MATT"
  display_name      = "Terraform Test User"
  initial_password  = "Password1234#@!#$"
  container         = ad_ou.o.dn
}

resource "ad_user" "usery" {
  principal_name    = "bobby"
  sam_account_name  = "BPBBY"
  display_name      = "Terraform Test User"
  initial_password  = "Password1234#@!#$"
  container         = ad_ou.o.dn
}




resource "ad_group_membership" "groupz_userz" {
  group_id = ad_group.groupz.id
  group_members = [ad_user.userz.id]
}

resource "ad_group_membership" "groupy_usery" {
  group_id = ad_group.groupy.id
  group_members = [ad_user.usery.id]
}
