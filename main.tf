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
  winrm_hostname = aws_instance.ad_instance.public_ip
  winrm_username = var.ad_admin_username
  winrm_password = var.ad_admin_password
}