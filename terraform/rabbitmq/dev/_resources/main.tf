terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "=1.8.0"
    }
  }
}

# resource "rabbitmq_vhost" "sawsx" {
#   name = "sawsx"
# }
