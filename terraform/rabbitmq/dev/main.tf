module "rabbitmq_resources" {
  source = "./_resources"
  providers = {
    rabbitmq = rabbitmq.rabbitmq1
  }
}
