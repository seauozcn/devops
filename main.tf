terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.0.2"
    }
  }
  required_version = ">= 1.0.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-dhbw-devops" {
  name     = "rg-dhbw-devops"
  location = "eastus2"
}

resource "azurerem_service_plan" "app-servie-plan" {
  name = "plan-dhbw"
  resource_group_name = azurerm_resource_group.rg-dhbw-devops.name
  location = azurerm_resource_group.rg-dhbw-devops.location
  sku_name = "F1"
  os_type = "Linux"
}

resource "azurerem_linux_web_app" "app" {
  name = "app-dhbw-test123" # eigener Name
  resource_group_name = azurerm_resource_group.rg-dhbw-devops.name
  location = azurerm_resource_group.rg-dhbw-devops.location
  service_plan_id = azurerem_service_plan.app-service-plan.id

  site_config {
    always_on = false
    application_stack {
      docker_image = "robinlieb/dhbw" # docker image name
      docker_image_tag = "latest"
    }
  }
}