mock_provider "vault" {}

run "defaults_plan_succeeds_with_oidc" {
  command = plan

  variables {
    bound_audiences    = ["vault", "kubernetes"]
    cluster_name       = "dev-cluster"
    jwt_issuer         = "https://issuer.example.com"
    oidc_discovery_url = "https://issuer.example.com"
  }

  assert {
    condition     = output.cluster_name == "dev-cluster"
    error_message = "cluster_name output should echo input."
  }

  assert {
    condition     = jsonencode(output.bound_audiences) == jsonencode(["vault", "kubernetes"])
    error_message = "bound_audiences output should echo input."
  }

  assert {
    condition     = output.jwt_auth_path == "jwt/dev-cluster"
    error_message = "jwt_auth_path should use jwt/<cluster_name> naming."
  }
}
