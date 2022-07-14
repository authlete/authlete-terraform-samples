provider "authlete" {

}


resource "authlete_service" "as" {
   issuer = "https://as.mydomain.com"
   service_name = "MyDomainAS_${terraform.workspace}"
   description = "A terraform based service for managing the ${terraform.workspace} Authlete based OAuth server"
   supported_grant_types = ["AUTHORIZATION_CODE"]
   #supported_grant_types = ["AUTHORIZATION_CODE", "CLIENT_CREDENTIALS"]
   supported_response_types = ["CODE"]
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
}


