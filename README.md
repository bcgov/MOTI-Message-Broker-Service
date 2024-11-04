# MOTI Message Broker Service

## Project Overview

This application manages a message queue system using RabbitMQ to support multiple projects across the Ministry of Transportation.

## Key Technologies Used

### Message Queue

- [RabbitMQ](https://www.rabbitmq.com/): A reliable and mature messaging and streaming broker.

### Runtime Version Manager

- [asdf](https://asdf-vm.com/): Manages multiple runtime versions to simplify dependency management and ensure consistency across development environments.

### Linters & Formatters

- [pre-commit](https://pre-commit.com/): Manages multi-language pre-commit hooks to enforce project standards and best practices, reducing the likelihood of bugs or inconsistencies.

### Deployment Tools

- [GitHub Actions](https://docs.github.com/en/actions/learn-github-actions/understanding-github-actions): Automates tasks such as building, testing, and deploying applications within GitHub repositories.

- [Helm](https://helm.sh/docs/): Kubernetes package manager simplifying the deployment, management, and scaling of applications in Kubernetes clusters.

### Infrastructure as Code

- [Terraform](https://www.terraform.io/): An open-source IaC tool that automates the provisioning and management of infrastructure across various cloud providers, facilitating efficient deployments, peer reviews, and version control.

## OpenShift Deployers

Terraform is used to generate an `OpenShift service account token` for GitHub pipelines.

- See [oc-deployers - README.md](./terraform/oc-deployers/README.md) for more details and instructions.

## Deployment & Release Life Cycle

The project manages three distinct environments: Development, Test, and Production, each with tailored deployment processes.

### Development

The Development environment uses continuous deployment for all changes made to the main branch, allowing us to assess the application’s current state based on the latest code.

- Refer to [deploy-dev.yml](.github/workflows/deploy-dev.yml) for more details.

### Test & Production

The Test and Production environments support deployment via GitHub dispatcher events. The selected environment determines where the resources are deployed.

- Refer to [deploy-dispatch.yml](.github/workflows/deploy-dispatch.yml) for more details.

### Local Deployment

To deploy resources from a local environment, follow these steps:

1. Log in to the target OpenShift cluster where you want to deploy:

   ```sh
   oc login --token=sha256~abcdef --server=https://api.<cluster>.devops.gov.bc.ca:6443
   ```

2. Navigate to the Helm directory:

   ```sh
   cd helm/main
   ```

3. Run the following command to deploy with Helm:

   ```sh
   make upgrade NAMESPACE=<namespace>
   ```
