output "cluster_name" {
  description = "Echo of cluster_name input."
  value       = var.cluster_name
}

output "jwt_auth_path" {
  description = "JWT auth backend path for this cluster trust mount."
  value       = vault_jwt_auth_backend.this.path
}

output "jwt_mount_accessor" {
  description = "JWT auth mount accessor for identity alias creation in principal modules."
  value       = vault_jwt_auth_backend.this.accessor
}
