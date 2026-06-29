# terraform-vault-cluster-onboarding

Trust-layer module that creates one Vault JWT auth backend at `jwt/<cluster_name>` for an OpenShift or Kubernetes issuer.

## Layer

Trust. This module creates trust only. It does not create principals, policies, or secret engines.

## Prerequisites

- HCP Terraform project configured with Vault dynamic credentials (`TFC_VAULT_*`)
- Tenant namespace inherited through `VAULT_NAMESPACE`

## No-code notes

- This module is no-code ready and declares its own `vault` provider.
- It creates trust only and outputs values for principal modules.
- It does not set resource-level `namespace`.

## Inputs

| Name | Type | Description |
|---|---|---|
| `cluster_name` | `string` | Cluster identifier, regex validated |
| `jwt_issuer` | `string` | OIDC issuer URL |
| `oidc_discovery_url` | `string` | Optional discovery URL, mutually exclusive |
| `jwks_url` | `string` | Optional JWKS URL, mutually exclusive |
| `jwt_validation_pubkeys` | `list(string)` | Optional PEM keys, mutually exclusive |
| `bound_audiences` | `list(string)` | Echoed for downstream principal role binding, default `["vault"]` |
| `default_lease_ttl` | `string` | Tune default TTL, default `1h` |
| `max_lease_ttl` | `string` | Tune max TTL, default `24h` |
| `vault_namespace` | `string` | Render-only, default `""` |
| `vault_address` | `string` | Render-only, default `""` |

## Outputs

| Name | Description |
|---|---|
| `jwt_auth_path` | JWT mount path (`jwt/<cluster_name>`) |
| `jwt_mount_accessor` | JWT mount accessor for entity alias creation |
| `cluster_name` | Echo |
| `bound_audiences` | Echo |
| `vault_namespace` | Echo |
| `vault_address` | Echo |

## Registry usage

```hcl
module "cluster_onboarding" {
  source  = "app.terraform.io/<org>/cluster-onboarding/vault"
  version = "~> 0.1"

  cluster_name       = "ocp-prod-eu"
  jwt_issuer         = "https://kubernetes.default.svc"
  oidc_discovery_url = "https://kubernetes.default.svc"
  bound_audiences    = ["vault"]
}
```

Next step in chain: `terraform-vault-add-k8s-namespace-access`.
