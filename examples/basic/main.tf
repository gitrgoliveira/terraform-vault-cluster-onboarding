terraform {
  required_version = ">= 1.9"
}

module "cluster_onboarding" {
  source = "../../"

  cluster_name       = var.cluster_name
  jwt_issuer         = var.jwt_issuer
  oidc_discovery_url = var.oidc_discovery_url
}

variable "cluster_name" {
  type        = string
  description = "Cluster identifier."
}

variable "jwt_issuer" {
  type        = string
  description = "OIDC issuer URL."
}

variable "oidc_discovery_url" {
  type        = string
  description = "OIDC discovery URL."
}
