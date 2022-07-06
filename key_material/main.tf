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
    crv = "P-256"
    kty = "EC"
    d   = "VT0W-vHxG8Wc0Ev0UT1jIs0XKfctQfQc93WV5Bqb2a0"
    use = "sig"
    x   = "coUEzc60fSaVWui-NCUEqAKwFq_isrQbdcxk-jafyTw"
    y   = "b9hCE1LgOry4mEUFgfz49NBEiNuC5mbBgb9glVZp420"
    alg = "ES256"
  }

  jwk {
    kid = "sym1"
    kty = "oct"
    alg = "A128KW"
    k   = "GawgguFyGrWKav7AX4VKUg"
    use = "enc"
  }

}



output "api_key" {
   value = authlete_service.as.id
}

output "api_secret" {
   value = authlete_service.as.api_secret
   sensitive = true
}
