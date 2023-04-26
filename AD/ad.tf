
/*
resource "ad_ou" "o" { 
    name = "top_org"
    path = "dc=${var.ad_domain},dc=com"
    description = "OU for tests"
    protected = false
}
*/

resource "ad_group" "groupz" {
  name             = "groupz"
  sam_account_name = "GROUPZ"
  scope            = "global"
  category         = "security"
  container        = var.ad_container
}

resource "ad_group" "groupy" {
  name             = "groupy"
  sam_account_name = "GROUPY"
  scope            = "global"
  category         = "security"
  container        = var.ad_container
}


resource "ad_user" "sally" {
  principal_name    = "sally"
  sam_account_name  = "SALLY"
  display_name      = "Terraform Test User"
  initial_password  = "Password1234#@!#$"
  container         = var.ad_container
}

resource "ad_user" "bobby" {
  principal_name    = "bobby"
  sam_account_name  = "BOBBY"
  display_name      = "Terraform Test User"
  initial_password  = "Password1234#@!#$"
  container         = var.ad_container
}

resource "ad_user" "sa-1" {
  principal_name = "sa-1"
  sam_account_name = "SA1"
  display_name = "Service Account 1"
  initial_password = "Password1234#@!#$"
  container = var.ad_container
}



resource "ad_group_membership" "groupz_userz" {
  group_id = ad_group.groupz.id
  group_members = [ad_user.bobby.id]
}

resource "ad_group_membership" "groupy_usery" {
  group_id = ad_group.groupy.id
  group_members = [ad_user.sally.id]
}
