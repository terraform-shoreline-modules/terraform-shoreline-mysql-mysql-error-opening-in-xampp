terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "error_opening_mysql_in_xampp" {
  source    = "./modules/error_opening_mysql_in_xampp"

  providers = {
    shoreline = shoreline
  }
}