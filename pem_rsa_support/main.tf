provider "authlete" {

}

provider "local" {
}



data "local_file" "ca_rsa" {
   filename = "${path.module}/ca_rsa.pem"
}

resource "authlete_service" "as" {
   issuer = "https://${terraform.workspace}.mydomain.com"
   service_name = "My_RSA_AS_${terraform.workspace}"
   description = "A terraform based service for managing the ${terraform.workspace} Authlete based OAuth server"
   supported_grant_types = ["AUTHORIZATION_CODE"]
   supported_response_types = ["CODE"]
   access_token_sign_alg = "RS256"
   access_token_signature_key_id = "rsa1"
   trusted_root_certificates = [ data.local_file.ca_rsa.content ]

   jwk {
      kid = "rsa1"
      alg = "RS256"
      use = "sig"
      pem_private_key = file("server_rsa_cert_with_key.pem")
   }
   jwk {
      kid = "rsa2"
      alg = "RS256"
      use = "sig"
      pem_private_key = file("server_rsa_key.pem")
      pem_certificate = file("server_rsa_cert.pem")
   }
   jwk {
      kid = "rsa3"
      alg = "RS256"
      use = "sig"
      pem_private_key = file("server_rsa_key.pem")
      pem_certificate = file("server_rsa_cert_chain.pem")
   }
   jwk {
      kid = "rsa4"
      alg = "RS256"
      use = "sig"
      pem_certificate = file("server_rsa_cert.pem")
   }
   jwk {
      kid = "rsa5"
      alg = "RS256"
      use = "sig"
      pem_certificate = file("server_rsa_cert_chain.pem")
   }

}

resource "authlete_client" "portal" {
   service_api_key = authlete_service.as.id
   service_api_secret = authlete_service.as.api_secret
   developer = "mydomain"
   client_id_alias = "portal_client"
   client_id_alias_enabled = false
   client_type = "CONFIDENTIAL"
   redirect_uris = concat([ "https://${terraform.workspace}.mydomain.com/cb",],
      var.portal_client_additional_redirects )
   response_types = [ "CODE" ]
   grant_types = [ "AUTHORIZATION_CODE", "REFRESH_TOKEN"]
   client_name = "Customer Portal client - ${terraform.workspace}"
   requestable_scopes = ["openid", "profile"]
   access_token_duration = 30
   refresh_token_duration = 14400

   jwk {
      kid = "cli1"
      alg = "RS256"
      use = "sig"
      pem_certificate = file("client_rsa_cert.crt")
   }
   jwk {
      kid = "cli2"
      alg = "RS256"
      use = "sig"
      pem_certificate = file("client_rsa_cert_chain.pem")
   }
}