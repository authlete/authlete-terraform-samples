output "api_key" {
  value = authlete_service.as.id
}

output "api_secret" {
  value = authlete_service.as.api_secret
  sensitive = true
}

output "client_id" {
  value = authlete_client.portal.id
}

output "client_secret" {
  value = authlete_client.portal.client_secret
  sensitive = true
}
