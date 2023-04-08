variable environment_name {
  default = "ad-demo-env-aws"
}

variable aws_vpc_cidr {
  default = "172.31.0.0/16"
  description = "CIDR block for the VPC"
}

variable region {
  default = "us-east-1"
}




variable tfc_org {
  default = "mattygrecgrec"
}

variable tfc_workspace {
  default = "ad-demo-env-aws"
}


variable hcp_hvn_cidr {
  default = "172.25.16.0/20"
}

variable windows_public_key {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnQ34b9kHJrbhpIE0yLWKqnczzdKPBKF7KeaH1knBWCfalabiVBo1q0YIMl65SZFeFfaH3qPr8JilKejuqqfI5gX774+ZuqnzpEmY41rQ5h8FKclcNepJI0DonzYERNNtZzARO4snbwx28LYnYYOWnEzMKXMoj7h566rPvlOunzD0xopQF9F0gYSUMsiGFmXr0NYtC77Ch2YLfubtxb9rWJ2MQSp3Zq5oQ2Df90k/3PFJ79h8khgqaSU9D43ZsMpQooWn0mimIDYCa2Je0yWVOvQ/KJL+uSSBwZdjik0HRzsVfXoGZz4IgRXXKvAnW2jJmAGs2EvC9pevKp5TesJ2Z"
}
/*
variable windows_private_key {
  default = "-----BEGIN RSA PRIVATE KEY-----MIIEowIBAAKCAQEAp0N+G/ZBya24aSBNMi1iqp3M83SjwSheynmh9ZJwVgn2pWmlQaNatGCDJeuUmRXhX2h96j6/CYpSno7qqnyOYF+++Pmbqp86RJmONa0OYfBSnJXDXqSSNA6J82BETTbWcwETuLJ28MdvC2J2GDlpxMzClzKI+4eeuqz75Trp8w9MaKUBfRdIGElDLIhhZl69DWLQu+wodmC37m7cW/a1idjEEqd2auaENg3/dJP9zxSe/YfJIYKmklPQ+N2bDKUKKFp9JopiA2AmtiXtMllTr0PyiS/rkkgcGXY4pNB0c7FX16Bmc+CIEV1yrwJ1toyZgBrNhLwvaXryqeU3rCdmQIDAQABAoIBAHEIKzC6ObsQqo5gRcqi4QprmRTsvbzKi0RI7ioFy+RY11TxHMuYofiNnFTmK+eB56NOQyYaC4JaR40NDUVHk2lJGYcfe5lNnRvkUzAV57T5CKZGno19R13tWV+MgKwgDBuiw0aL+92G/ZEtNPoEgS1mzBc0nWWqhO6LrQ06lgXN5cIZHVMk+86nlrJsv6YtGsBAwXxl1nqVpvdiGP8IbsrMlNFrjqkLtUP/FoRRqlw7Y/xu9HCo+8vmntFFgrnUO+xwSIHGywUGEhkH93lT42YclQDaBIAOfCGqw16cjvb/pLl7D3e01oZ51N6XSzwAKbnpnCgRkgqzAYzNxvvwJAECgYEA6fvuJRB1MK21x8IuzePooCNFST9m2qJQpVsTHDadgr/qK7eRECzwPV5EF2BnBIqVerHcI1zI9LdkiFbXDaLjq0J4VsFjltxa5yATn6sGQ1ZLXxsy5f6SeXjwGCPZVwsuv+6nDl3XxIC5LUkGVpZKRWVHaW8F/e4b2MIXBOtV28cCgYEAtwBwjWiJE10CFb3qQEkEFh1bh/MHnfMSSjSw4rzZG6zVFGYKYqRw1Bkes9UMUdFtgCkRMT01zLO2SY/7pXXwQ4fwiamBmOQzNKzuTpjdO4f7Vj9SAR6WHoyxGXoaNWQi0g7ePgoAKsiEWzuJELxtTZeMHcp8Vcqzb+PaEQEX+58CgYBIMM5c6SL/DdlT9Hl0VKjlH3y1CLa3JfUzz1GqFr+qI4QgUNaU4wiMJpVjkP63y/oqjM2aq3nk5uBBoGlhb6xGno96VNhhJ0N0o9TqIl4gUHOYuE+P3mdayxFooUbhMDYQSZWJPTLhEcYQTsOB24S2vHS39uUmX1yAGAH6JpGq6QKBgQCysAM2kHQILDD0+dPZoXIUBeZyAKPXXpjlTD3Lp4p2s3P7zwck+lwRPdX00nqNCWlaUr8uzQ3TK0c63RRio55O0lXUlWat22UEcjbfF/QtRMHtnTZ9UVhTzBzBO7CLoZM+eLYY7brsC47xZliXtuUjdm6iSCzPuHUtM9ah8+dvEQKBgGt4r1DZvTjtdHhBr2jS36237WSRwGS4Ze2HH5+DOnruhAo5jbZo1l1CK+xNmTGD1R274B1ABoIkHkCXbnbEMDaiYiRhRYD76HcS0kS1dVGOjmccv29YY4QtEnlUJGOBjzFLVPFX0ve5kROMEQ/FZ0IPwSssm+tqoUD5nHXnkV3e-----END RSA PRIVATE KEY----"
}*/


variable "owner" {
  default     = "mattygrecgrec"
}

variable "app_version" {
  default     = "0.1"
}

variable "ad_admin_password" {
  default     = "rJ;ZR(@TdegRxM)X8InHb;afFfn=DXj3"
}

variable "ad_admin_username" {
  default     = "Administrator"
}

variable "ad_domain_name" {
  default     = "mattygrecgrec.com"
}

variable "ad_netBIOS_name" {
  default     = "MATTYGREC"
}