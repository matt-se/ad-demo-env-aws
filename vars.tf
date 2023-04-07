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

variable hcp_client_id {
  default = "NesRmeMDPDtabpQ8VWAvYLVBZ8ad77CN"
}

variable hcp_client_secret {
  default = "replace me!"
}

variable hcp_hvn_cidr {
  default = "172.25.16.0/20"
}