# terraform-vault-cluster-onboarding

Trust-layer module that creates one Vault JWT auth backend at `jwt/<cluster_name>` for an OpenShift or Kubernetes issuer.

## Layer

Trust. This module creates trust only. It does not create workloads, policies, or secret engines.

## Prerequisites

- HCP Terraform project configured with Vault dynamic credentials (`TFC_VAULT_*`)
- Tenant namespace inherited through `VAULT_NAMESPACE`

## No-code notes

- This module is no-code ready and declares its own `vault` provider.
- It creates trust only and outputs values for workload modules.
- It does not set resource-level `namespace`.

## Inputs

| Name | Type | Description |
|---|---|---|
| `cluster_name` | `string` | Cluster identifier, regex validated |
| `jwt_issuer` | `string` | OIDC issuer URL |
| `oidc_discovery_url` | `string` | Optional discovery URL, mutually exclusive |
| `jwks_url` | `string` | Optional JWKS URL, mutually exclusive |
| `jwt_validation_pubkey` | `string` | Optional single PEM public key, mutually exclusive |
| `default_lease_ttl` | `string` | Tune default TTL, default `1h` |
| `max_lease_ttl` | `string` | Tune max TTL, default `24h` |

## Outputs

| Name | Description |
|---|---|
| `jwt_auth_path` | JWT mount path (`jwt/<cluster_name>`) |
| `jwt_mount_accessor` | JWT mount accessor for entity alias creation |
| `cluster_name` | Echo |

## No-code provisioning

This module is no-code enabled in the `hc-ric-demo` private registry (pinned to `0.2.0`). To deploy without writing HCL: open the module in the registry, click **Provision workspace**, choose a project and workspace name, then complete the form.

Form fields:

| Field | Required | Notes |
|---|---|---|
| `cluster_name` | yes | Cluster identifier |
| `jwt_issuer` | yes | OIDC issuer URL |
| `oidc_discovery_url` / `jwks_url` / `jwt_validation_pubkey` | yes | Set exactly one |
| `default_lease_ttl` / `max_lease_ttl` | no | Tune TTLs |

The first run plans automatically after the workspace is created.

## Registry usage

```hcl
module "cluster_onboarding" {
  source  = "app.terraform.io/<org>/cluster-onboarding/vault"
  version = "~> 0.2.0"

  cluster_name       = "ocp-prod-eu"
  jwt_issuer         = "https://oidc.ocp-prod-eu.example.com"
  oidc_discovery_url = "https://oidc.ocp-prod-eu.example.com"
}
```

Vault fetches `<oidc_discovery_url>/.well-known/openid-configuration` and the JWKS it names, so the discovery URL must be reachable from HCP Vault without authentication and served with a publicly trusted certificate. Vault also checks that the `issuer` in the discovery document equals `oidc_discovery_url`, so `jwt_issuer` and `oidc_discovery_url` must both be the issuer the cluster actually puts in its tokens. The in-cluster default issuer `https://kubernetes.default.svc` is not reachable from outside the cluster, and a proxy in front of it still serves that issuer, so either:

- set the cluster's service account issuer (`kube-apiserver --service-account-issuer`; on OpenShift, `spec.serviceAccountIssuer` in `authentication.config/cluster`) to a public URL that serves discovery without authentication (bind `system:service-account-issuer-discovery` to `system:unauthenticated`), and use that URL for both inputs; or
- keep `jwt_issuer` equal to the tokens' `iss` claim and set `jwks_url` to a reachable JWKS endpoint, or pass the cluster's signing key as `jwt_validation_pubkey` (re-provision after the cluster rotates that key).

Next step in chain: `terraform-vault-add-k8s-namespace-access`.
