provider "authlete" {

}

resource "authlete_client" "portal" {
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


output "client_id" {
   value = authlete_client.portal.id
}

output "client_secret" {
   value = authlete_client.portal.client_secret
   sensitive = true
}
