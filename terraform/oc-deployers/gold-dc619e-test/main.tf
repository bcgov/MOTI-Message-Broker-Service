module "oc_deployer" {
  source = "../_module"

  name                  = "oc-deployer"
  namespace             = "dc619e-test"
  privileged_namespaces = ["dc619e-test"]
}

output "service_account_id" {
  value = module.oc_deployer.service_account_id
}
