terraform {
  required_providers {
      authlete = {
      source = "authlete/authlete"
      version = ">= 0.1"
    }
  }
}

provider "authlete" {

}

resource "authlete_service" "as" {
  issuer = "https://as.mydomain.com"
  service_name = "MyDomainAS"
  description = "A terraform based service for managing the Authlete based OAuth server"
  supported_grant_types = ["AUTHORIZATION_CODE"]
  supported_response_types = ["CODE"]
}


output "api_key" {
   value = authlete_service.as.id
}

output "api_secret" {
   value = authlete_service.as.api_secret
   sensitive = true
}
