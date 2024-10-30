terraform {
  required_version = ">=1.5.7"

  backend "kubernetes" {
    namespace     = "f73c1f-dev"
    secret_suffix = "rabbitmq" # pragma: allowlist secret
    config_path   = "~/.kube/config"
  }

  required_providers {
    # See https://registry.terraform.io/providers/cyrilgdn/rabbitmq/latest
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "=1.8.0"
      configuration_aliases = [ rabbitmq.rabbitmq1 ]
    }
  }
}

provider "rabbitmq" {
  alias    = "rabbitmq1"
  endpoint = var.endpoint
  username = var.username
  password = var.password
}
