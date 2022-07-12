provider "authlete" {

}

provider "local" {
}

data "local_file" "ca_ec" {
   filename = "${path.module}/ca_ec.crt"
}

resource "authlete_service" "as" {
   issuer = "https://${terraform.workspace}.mydomain.com"
   service_name = "My_EC_AS_${terraform.workspace}"
   description = "A terraform based service for managing the ${terraform.workspace} Authlete based OAuth server"
   supported_grant_types = ["AUTHORIZATION_CODE"]
   supported_response_types = ["CODE"]
   access_token_sign_alg = "ES256"
   access_token_signature_key_id = "ec1"
   trusted_root_certificates = [ data.local_file.ca_ec.content]

   jwk {
      kid = "ec1"
      alg = "ES256"
      use = "sig"
      pem_private_key = file("server_ec_cert_with_key.pem")
   }
   jwk {
      kid = "ec2"
      alg = "ES256"
      use = "sig"
      pem_private_key = file("server_ec_key.pem")
      pem_certificate = file("server_ec_cert.pem")
   }
   jwk {
      kid = "ec3"
      alg = "ES256"
      use = "sig"
      pem_private_key = file("server_ec_key.pem")
      pem_certificate = file("server_ec_cert_chain.pem")
   }
   jwk {
      kid = "ec4"
      alg = "ES256"
      use = "sig"
      pem_certificate = file("server_ec_cert.pem")
   }
   jwk {
      kid = "ec5"
      alg = "ES256"
      use = "sig"
      pem_certificate = file("server_ec_cert_chain.pem")
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
      alg = "ES256"
      use = "sig"
      pem_certificate = file("client_ec_cert.pem")
   }
   jwk {
      kid = "cli2"
      alg = "ES256"
      use = "sig"
      pem_certificate = file("client_ec_cert_chain.pem")
   }
}


