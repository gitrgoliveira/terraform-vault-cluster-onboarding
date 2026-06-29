terraform {
  required_version = ">= 1.9"
}

module "cluster_onboarding" {
  source = "../../"

  bound_audiences    = var.bound_audiences
  cluster_name       = var.cluster_name
  jwt_issuer         = var.jwt_issuer
  oidc_discovery_url = var.oidc_discovery_url
  vault_address      = var.vault_address
  vault_namespace    = var.vault_namespace
}

variable "bound_audiences" {
  type        = list(string)
  description = "Audience list used by downstream principal roles."
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

variable "vault_address" {
  type        = string
  description = "Render-only Vault address."
  default     = ""
}

variable "vault_namespace" {
  type        = string
  description = "Render-only Vault namespace."
  default     = ""
}
