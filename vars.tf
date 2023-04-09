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