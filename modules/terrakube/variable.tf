
variable "github_oauth_client_id" {
  type      = string
  default   = "Ov23liQUwQ10Bhm7Rodt"
  sensitive = true
}

variable "github_oauth_client_secret" {
  type      = string
  default   = "493f3e0535dd4c8856a0b46b1dafb7bc30458516"
  sensitive = true
}

variable "terrakube_namespace" {
  type        = string
  default     = "terrakube"
  description = "Namespace for Terrakube deployment"
}
