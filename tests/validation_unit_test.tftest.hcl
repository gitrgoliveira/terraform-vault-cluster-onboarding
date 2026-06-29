mock_provider "vault" {}

run "multiple_jwt_verification_sources_fail_validation" {
  command = plan

  variables {
    bound_audiences    = ["vault"]
    cluster_name       = "dev-cluster"
    jwt_issuer         = "https://issuer.example.com"
    oidc_discovery_url = "https://issuer.example.com"
    jwks_url           = "https://issuer.example.com/jwks"
  }

  expect_failures = [
    var.oidc_discovery_url,
  ]
}

run "invalid_cluster_name_fails_validation" {
  command = plan

  variables {
    bound_audiences    = ["vault"]
    cluster_name       = "-bad"
    jwt_issuer         = "https://issuer.example.com"
    oidc_discovery_url = "https://issuer.example.com"
  }

  expect_failures = [
    var.cluster_name,
  ]
}
