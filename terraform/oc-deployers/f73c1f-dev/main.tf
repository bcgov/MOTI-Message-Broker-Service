module "oc_deployer" {
  source = "../_module"

  name                  = "oc-deployer"
  namespace             = "f73c1f-dev"
  privileged_namespaces = ["f73c1f-dev"]
}

output "service_account_id" {
  value = module.oc_deployer.service_account_id
}
