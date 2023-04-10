resource "ad_ou" "o" { 
    name = "top_org"
    path = "dc=mattygrecgrec,dc=com"
    description = "OU for tests"
    protected = false
}

