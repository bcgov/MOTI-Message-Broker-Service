# How to Configure IP Whitelisting for an OpenShift Route Using Helm

## Introduction

In OpenShift Container Platform (OCP), IP whitelisting is a security feature that restricts access to routes based on IP addresses. By configuring IP whitelisting, you can control which IP addresses are allowed to access your application services, enhancing security and preventing unauthorized access. This is particularly useful for limiting access to management interfaces or sensitive endpoints.

The `haproxy.router.openshift.io/ip_whitelist` annotation is used to specify a comma-separated list of IP addresses or CIDR ranges that are allowed to access the route. The format for the IP whitelist string can include individual IP addresses (e.g., `192.168.1.1`), or CIDR ranges (e.g., `192.168.1.0/24`).

## Steps

### Define IP Whitelist in Environment-Specific Values Files

Each environment should have its own values file under `/helm/main`. Define the IP whitelist in these values files according to the environment. For example:

#### Example: `/helm/main/values-f73c1f-dev.yaml`

```yaml
rabbitmq:
  ipWhitelist: '10.0.0.1,10.0.0.2'
```
