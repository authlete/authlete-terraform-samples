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
  id_token_signature_key_id = "ec1"
  user_info_signature_key_id = "ec1"
  authorization_signature_key_id = "ec1"

  jwk {
    kid = "ec1"
    alg = "ES256"
    use = "sig"
    crv = "P-256"
    generate = true
  }

  # second step is to include a new key
  #  jwk {
  #    kid = "ec2"
  #    alg = "ES256"
  #    use = "sig"
  #    crv = "P-256"
  #    generate = true
  #  }

  # third step is to change the key used to sign tokens
  # access_token_signature_key_id = "ec2"
  # id_token_signature_key_id = "ec2"
  # user_info_signature_key_id = "ec2"
  # authorization_signature_key_id = "ec2"

  # fourth step is to remove key ec1
  # and the key rotation is completed

}


output "api_key" {
  value = authlete_service.as.id
}

output "api_secret" {
  value = authlete_service.as.api_secret
  sensitive = true
}

