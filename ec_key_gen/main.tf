provider "authlete" {

}

resource "authlete_service" "as" {
  issuer = "https://as.mydomain.com"
  service_name = "MyDomainAS"
  description = "A terraform based service for managing the Authlete based OAuth server"
  supported_grant_types = ["AUTHORIZATION_CODE"]
  supported_response_types = ["CODE"]
  access_token_sign_alg = "ES256"
  access_token_signature_key_id = "ec1"
  jwk {
    kid = "ec1"
    alg = "ES256"
    use = "sig"
    crv = "P-256"
    generate = true
  }
  jwk {
    kid = "ec3"
    alg = "ES384"
    use = "sig"
    crv = "P-384"
    generate = true
  }
  jwk {
    kid = "ec4"
    alg = "ES512"
    use = "sig"
    crv = "P-521"
    generate = true
  }
  jwk {
    kid = "enc1"
    alg = "ECDH-ES"
    use = "enc"
    crv = "P-256"
    generate = true
  }
  jwk {
    kid = "enc2"
    alg = "ECDH-ES+A128KW"
    use = "enc"
    crv = "P-256"
    generate = true
  }
  jwk {
    kid = "enc3"
    alg = "ECDH-ES+A192KW"
    use = "enc"
    crv = "P-256"
    generate = true
  }
  jwk {
    kid = "ed1"
    alg = "EdDSA"
    use = "sig"
    crv = "Ed25519"
    kty = "OKP"
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
