terraform {
  required_providers {
    authlete = {
      source = "authlete/authlete"
      version = ">= 1.1.0"
    }
    local = {
      source = "hashicorp/local"
      version = "2.2.3"
    }
  }
}

