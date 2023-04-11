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
      required_version = ">= 0.4.4"
    }
    vault = {
      source  = "hashicorp/vault"
      version = ">= 3.14.0"
    }
  }
  required_version = ">= 1.2.0"
}


provider "ad" {
  #winrm_hostname = aws_instance.windows.public_ip
  winrm_hostname = "44.204.59.30"
  winrm_username = var.ad_admin_username
  winrm_password = rsadecrypt(aws_instance.windows.password_data,file("dales-dead-bug_frontend_windows_dev_keypair.pem"))
  winrm_use_ntlm = true
  winrm_port     = 5985
  winrm_proto    = "http"
  winrm_insecure = true
}