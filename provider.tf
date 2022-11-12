# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  backend "remote" {
    organization = "rahmandemo"

    workspaces {
      name = "octopus-prime"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}
