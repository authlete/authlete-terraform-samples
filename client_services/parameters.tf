variable "authlete_service_test_api_key" {
  type = string
  description = "The api key of the Authlete test service"
  nullable = false
}

variable "authlete_service_test_api_secret" {
  type = string
  description = "The api secret of the Authlete test service"
  sensitive = true
  nullable = false
}

variable "authlete_service_production_api_key" {
  type = string
  description = "The api key of the Authlete production service"
  nullable = false
}

variable "authlete_service_production_api_secret" {
  type = string
  description = "The api secret of the Authlete production service"
  sensitive = true
  nullable = false
}
