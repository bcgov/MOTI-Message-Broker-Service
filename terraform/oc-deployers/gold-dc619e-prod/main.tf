module "oc_deployer" {
  source = "../_module"

  name                  = "oc-deployer"
  namespace             = "dc619e-prod"
  privileged_namespaces = ["dc619e-prod"]
}

output "service_account_id" {
  value = module.oc_deployer.service_account_id
}
