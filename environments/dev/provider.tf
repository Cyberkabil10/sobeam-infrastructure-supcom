terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.8"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.19.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
  }


  backend "remote" {
    organization = "sobeam-project-supcom"

    workspaces {
      name = "sobeam-infrastructure-supcom-dev"
    }
  }
}