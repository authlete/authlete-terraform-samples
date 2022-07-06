provider "authlete" {

}

resource "authlete_service" "as" {
  issuer = "https://as.mydomain.com"
  service_name = "MyDomainAS"
  description = "A terraform based service for managing the Authlete based OAuth server"
  supported_grant_types = ["AUTHORIZATION_CODE"]
  supported_response_types = ["CODE"]
  access_token_sign_alg = "RS256"
  access_token_signature_key_id = "rsa1"

  jwk {
    kid = "rsa1"
    alg = "RS256"
    use = "sig"
    kty = "RSA"
    key_size = 2048
    generate = true
  }

  jwk {
    kid = "rsa2"
    alg = "RS384"
    use = "sig"
    kty = "RSA"
    key_size = 2048
    generate = true
  }

  jwk {
    kid = "rsa3"
    alg = "PS512"
    use = "sig"
    kty = "RSA"
    key_size = 2048
    generate = true
  }

  jwk {
    kid = "rsa4"
    alg = "RSA-OAEP"
    use = "enc"
    kty = "RSA"
    key_size = 2048
    generate = true
  }

  jwk {
    kid = "rsa5"
    alg = "RSA-OAEP"
    use = "enc"
    kty = "RSA"
    key_size = 4096
    generate = true
  }

  jwk {
    kid = "rsa6"
    alg = "RSA-OAEP-256"
    use = "enc"
    kty = "RSA"
    key_size = 4096
    generate = true
  }
}



output "api_key" {
   value = authlete_service.as.id
}

output "api_secret" {
   value = authlete_service.as.api_secret
   sensitive = true
}
