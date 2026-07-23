# How to Uninstall and Re-deploy RabbitMQ

## When to Use This Runbook

Use this process in development or test OpenShift environments when a RabbitMQ version upgrade leaves the cluster in a bad state. Common symptoms include:

- existing RabbitMQ data is not compatible with the upgraded version
- the cluster fails during leader selection or node recovery

In these cases, uninstalling the Helm release, removing the persistent volume claims (PVCs), and deploying the chart again can help restore a clean cluster for active debugging or incident management.

## Required Tools

`helm` and `oc` are required for this process.

This repository includes a `helm/main/Makefile`, but the commands below use the `helm` CLI directly.

All commands in this document are examples. Update the release name, cluster values file, namespace, and PVC names as needed for the environment you are working in.

## Steps

### 1. Navigate to the Helm chart directory

```sh
cd helm/main
```

### 2. Uninstall the RabbitMQ release

```sh
helm uninstall moti-message-broker -n dc619e-<env>
```

### 3. Delete the PVCs manually

The PVCs are not removed by the Helm uninstall, so delete them manually before re-deploying the cluster.

```sh
oc project dc619e-<env>
oc get pvc
oc delete pvc data-moti-rabbitmq-0 data-moti-rabbitmq-1 data-moti-rabbitmq-2
```

### 4. Verify that the old pods and PVCs are gone

Before re-deploying, confirm that all RabbitMQ pods and PVCs have terminated.

Example checks:

```sh
oc get pods
oc get pvc
```

### 5. Re-deploy the RabbitMQ release

```sh
helm dependency update
helm upgrade --install "moti-message-broker" . -n "dc619e-<env>" -f values.yaml -f "values-gold-dc619e-<env>.yaml"
```
