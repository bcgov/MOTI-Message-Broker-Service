# OpenShift Deployment with Terraform

To implement `configuration as code` and streamline the creation of an `OpenShift service account token` for `GitHub Actions` to deploy Kubernetes resources on an OpenShift cluster, we use [Terraform](https://www.terraform.io/).

## Procedure

1. Navigate to the target namespace directory:

   ```sh
   cd <namespace>
   ```

2. Initialize the working directory with the Terraform configuration files:

   ```sh
   terraform init
   ```

3. Preview the infrastructure changes Terraform will make:

   ```sh
   terraform plan
   ```

4. Apply the changes specified in the Terraform plan:

   ```sh
   terraform apply
   ```

## Adding the Token to GitHub Secrets

1. After Terraform creates the service account and token, navigate to OpenShift Secrets.

2. Locate the token secret, which usually has a name like `oc-deployer-token-xxxxx`.

3. Copy the `token` value from the secret.

4. In GitHub, go to Settings for the specific environment and add the copied value to the secret named `OPENSHIFT_TOKEN`.
