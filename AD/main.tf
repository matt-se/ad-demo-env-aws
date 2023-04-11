terraform {
  backend "remote" {
    organization = var.tfc_org
    workspaces {
      name = var.tfc_workspace
    }
  }

  required_providers {
    ad = {
      source  = "hashicorp/ad"
      version = ">= 0.4.4"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.14.0"
    }
  }
  required_version = ">= 1.2.0"
}



provider "vault" {
  token = hcp_vault_cluster_admin_token.example.token
  address = hcp_vault_cluster.example.vault_public_endpoint_url
  namespace = "admin"
}



provider "ad" {
  #winrm_hostname = aws_instance.windows.public_ip
  winrm_hostname = var.ad_controller_public_ip
  winrm_username = "Administrator"
  #winrm_password = rsadecrypt(aws_instance.windows.password_data,file("dales-dead-bug_frontend_windows_dev_keypair.pem"))
  winrm_password = var.windows_password
  winrm_use_ntlm = true
  winrm_port     = 5985
  winrm_proto    = "http"
  winrm_insecure = true
}