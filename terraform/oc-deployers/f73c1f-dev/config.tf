terraform {
  required_version = ">=1.5.7"

  backend "kubernetes" {
    namespace     = "f73c1f-dev"
    secret_suffix = "oc-deployers" # pragma: allowlist secret
    config_path   = "~/.kube/config"
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "=2.32.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}
