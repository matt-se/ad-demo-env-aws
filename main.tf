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
  address = hcp_valut_cluster.example.public_endpoint
  namespace = "admin"
}