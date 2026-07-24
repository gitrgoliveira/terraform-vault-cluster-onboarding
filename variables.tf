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

  validation {
    condition     = can(regex("^[0-9]+[smh]?$", var.default_lease_ttl))
    error_message = "default_lease_ttl must be a duration like 3600, 60m, or 1h."
  }
}

variable "jwks_url" {
  type        = string
  description = "Optional JWKS URL for JWT signature verification."
  default     = ""
}

variable "jwt_issuer" {
  type        = string
  description = "OIDC issuer URL used as bound_issuer for the JWT auth backend."

  validation {
    condition     = startswith(var.jwt_issuer, "https://")
    error_message = "jwt_issuer must be an HTTPS URL."
  }
}

variable "jwt_validation_pubkey" {
  type        = string
  description = "Single PEM public key for JWT validation. Leave empty to use OIDC discovery or JWKS URL instead."
  default     = ""
}

variable "max_lease_ttl" {
  type        = string
  description = "Maximum lease TTL for the JWT auth backend tune block."
  default     = "24h"

  validation {
    condition     = can(regex("^[0-9]+[smh]?$", var.max_lease_ttl))
    error_message = "max_lease_ttl must be a duration like 3600, 60m, or 1h."
  }
}

variable "oidc_discovery_url" {
  type        = string
  description = "Optional OIDC discovery URL for JWT auth backend config."
  default     = ""

  validation {
    condition = (
      (var.oidc_discovery_url != "" ? 1 : 0) +
      (var.jwks_url != "" ? 1 : 0) +
      (var.jwt_validation_pubkey != "" ? 1 : 0)
    ) == 1
    error_message = "Set exactly one of oidc_discovery_url, jwks_url, or jwt_validation_pubkey."
  }
}
