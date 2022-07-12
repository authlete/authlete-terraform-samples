variable "portal_client_additional_redirects" {
  type = list(string)
  description = "additional redirects for the portal client"
  nullable = true
  default = []
}
