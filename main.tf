provider "vault" {
  skip_child_token = true
}

resource "vault_jwt_auth_backend" "this" {
  path                   = "jwt/${var.cluster_name}"
  bound_issuer           = var.jwt_issuer
  oidc_discovery_url     = var.oidc_discovery_url != "" ? var.oidc_discovery_url : null
  jwks_url               = var.jwks_url != "" ? var.jwks_url : null
  jwt_validation_pubkeys = length(var.jwt_validation_pubkeys) > 0 ? var.jwt_validation_pubkeys : null

  tune {
    default_lease_ttl = var.default_lease_ttl
    max_lease_ttl     = var.max_lease_ttl
  }
}
