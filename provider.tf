terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.8"
    }
  }
    cloud {
    organization = "sobeam-project-supcom"

    workspaces {
      name = "sobeam-infrastructure-supcom"
    }
  }
}