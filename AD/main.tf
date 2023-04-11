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
}



provider "ad" {
  winrm_hostname = var.ad_controller_public_ip
  winrm_username = "Administrator"
  winrm_password = var.windows_password
  winrm_port     = 5985
  winrm_proto    = "http"
  winrm_insecure = true
}