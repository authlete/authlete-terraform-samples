provider "authlete" {

}

resource "authlete_client" "test_portal" {
   api_key = var.authlete_service_test_api_key
   api_secret = var.authlete_service_test_api_secret
   developer = "mydomain"
   client_id_alias = "portal_client"
   client_id_alias_enabled = false
   client_type = "CONFIDENTIAL"
   redirect_uris = [ "https://test.mydomain.com/cb",
      "http://localhost:3000/cb" ]
   response_types = [ "CODE" ]
   grant_types = [ "AUTHORIZATION_CODE", "REFRESH_TOKEN"]
   client_name = "Customer Portal client"
   requestable_scopes = ["openid", "profile"]
   access_token_duration = 30
   refresh_token_duration = 14400
}

resource "authlete_client" "prod_portal" {
   api_key = var.authlete_service_production_api_key
   api_secret = var.authlete_service_production_api_secret
   developer = "mydomain"
   client_id_alias = "portal_client"
   client_id_alias_enabled = false
   client_type = "CONFIDENTIAL"
   redirect_uris = [ "https://www.mydomain.com/cb" ]
   response_types = [ "CODE" ]
   grant_types = [ "AUTHORIZATION_CODE", "REFRESH_TOKEN"]
   client_name = "Customer Portal client"
   requestable_scopes = ["openid", "profile"]
   access_token_duration = 30
   refresh_token_duration = 14400
}

