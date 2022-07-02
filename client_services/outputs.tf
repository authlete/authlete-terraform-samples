output "test_portal_client_id" {
  value = authlete_client.test_portal.client_id
}

output "test_client_secret" {
  value = authlete_client.test_portal.client_secret
  sensitive = true
}

output "prod_portal_client_id" {
  value = authlete_client.prod_portal.client_id
}

output "prod_portal_client_secret" {
  value = authlete_client.prod_portal.client_secret
  sensitive = true
}