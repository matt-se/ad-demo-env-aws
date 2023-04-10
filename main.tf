terraform {
  backend "remote" {
    organization = var.tfc_org
    workspaces {
      name = var.tfc_workspace
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.region
}


provider "hcp" {}


provider "vault" {
  token = hcp_vault_cluster_admin_token.example.token
  address = hcp_vault_cluster.example.vault_public_endpoint_url
  namespace = "admin"
}


provider "ad" {
  #winrm_hostname = aws_instance.windows.public_ip
  winrm_hostname = "44.204.59.30"
  winrm_username = var.ad_admin_username
  winrm_password = rsadecrypt(aws_instance.windows.password_data,file("dales-dead-bug_frontend_windows_dev_keypair.pem"))
  winrm_use_ntlm = true
  winrm_port     = 5986
  winrm_proto    = "https"
  winrm_insecure = true
}