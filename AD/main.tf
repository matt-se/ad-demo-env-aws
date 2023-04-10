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
