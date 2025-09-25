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
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.38.0"
    }
  }


  cloud { 
    
    organization = "sobeam-project-supcom" 

    workspaces { 
      name = "sobeam-infrastructure-supcom-dev" 
    } 
  }
}