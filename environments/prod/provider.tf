terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.8"
    }
  }

  backend "remote" {
    organization = "sobeam-project-supcom"

    workspaces {
      name = "sobeam-infrastructure-supcom-prod"
    }
  }
}