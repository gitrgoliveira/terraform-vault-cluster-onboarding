# Changelog

All notable changes to this project are documented in this file.

## [0.2.0] - 2026-07-24

### Changed
- **Breaking:** renamed `jwt_validation_pubkeys` (type `list(string)`) to `jwt_validation_pubkey` (type `string`). The module now accepts a single PEM public key instead of a list. Leave empty to use OIDC discovery or JWKS URL instead.

### Added
- Validation on `default_lease_ttl` and `max_lease_ttl` to enforce duration format (e.g. `3600`, `60m`, `1h`).
- Validation on `jwt_issuer` to require an `https://` prefix.

## [0.1.1] - 2026-07-07

### Changed
- Documentation: renamed the "principal" layer references to "workload" to match the onboarding terminology (no input/output or behavior change).

## [0.1.0] - 2026-07-07

### Removed
- **Breaking:** removed the `bound_audiences`, `vault_address`, and `vault_namespace` input variables and their echo outputs. These inputs were echoed straight back as outputs and did no work in the module; downstream principal modules already request these values as their own inputs.

## [0.0.2] - 2026-06-29

### Changed
- Documentation and version-consistency fixes: corrected the no-code registry pin, the registry-usage version constraint, and the CHANGELOG release header.

## [0.0.1]

### Added
- Initial no-code-ready module implementation.
