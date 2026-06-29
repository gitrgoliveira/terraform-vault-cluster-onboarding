variable "bound_audiences" {
  type        = list(string)
  description = "Audiences to be used by downstream JWT login roles."
  default     = ["vault"]
}

variable "cluster_name" {
  type        = string
  description = "Short cluster identifier used in mount naming."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{0,30}[a-z0-9]$", var.cluster_name))
    error_message = "cluster_name must match ^[a-z][a-z0-9-]{0,30}[a-z0-9]$."
  }
}

variable "default_lease_ttl" {
  type        = string
  description = "Default lease TTL for the JWT auth backend tune block."
  default     = "1h"
}

variable "jwks_url" {
  type        = string
  description = "Optional JWKS URL for JWT signature verification."
  default     = ""
}

variable "jwt_issuer" {
  type        = string
  description = "OIDC issuer URL used as bound_issuer for the JWT auth backend."
}

variable "jwt_validation_pubkeys" {
  type        = list(string)
  description = "Optional PEM public keys for JWT signature verification."
  default     = []
}

variable "max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for the JWT auth backend tune block."
  default     = "24h"
}

variable "oidc_discovery_url" {
  type        = string
  description = "Optional OIDC discovery URL for JWT auth backend config."
  default     = ""

  validation {
    condition = (
      (var.oidc_discovery_url != "" ? 1 : 0) +
      (var.jwks_url != "" ? 1 : 0) +
      (length(var.jwt_validation_pubkeys) > 0 ? 1 : 0)
    ) == 1
    error_message = "Set exactly one of oidc_discovery_url, jwks_url, or jwt_validation_pubkeys."
  }
}

variable "vault_address" {
  type        = string
  description = "Render-only Vault address value supplied via TF_VAR_vault_address."
  default     = ""
}

variable "vault_namespace" {
  type        = string
  description = "Render-only Vault namespace value supplied via TF_VAR_vault_namespace."
  default     = ""
}
