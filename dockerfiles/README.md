# Dockerfiles

This directory contains the managed RabbitMQ image sources used by this repository.

Each version is stored under its own path, for example `4.3/debian-12/`, and includes the Docker build context:

- `Dockerfile`
- `prebuildfs/`
- `rootfs/`
- optional local test files such as `docker-compose.yml`

The GitHub Actions workflow `.github/workflows/build-push-rabbitmq-managed.yml` builds and publishes the image from `dockerfiles/4.3/debian-12` to `ghcr.io/bcgov/bitnami-rabbitmq`.

## Updating RabbitMQ

Use this process when moving to a newer Bitnami RabbitMQ release.

1. Copy the new image directory from the upstream Bitnami RabbitMQ source:
   `https://github.com/bitnami/containers/tree/main/bitnami/rabbitmq`
2. Add or update the versioned directory in this repo, for example `dockerfiles/4.3/debian-12/`.
3. Compare the upstream Dockerfile with the version in this repo and keep any repo-specific fixes that are still required.
4. Build the image locally before opening a PR:

```sh
docker build --progress=plain -f dockerfiles/4.3/debian-12/Dockerfile dockerfiles/4.3/debian-12
```

5. If the version directory changed, update `.github/workflows/build-push-rabbitmq-managed.yml` so `docker-context`, `docker-file`, and `TAG_PREFIX` point at the new version.
6. After the workflow publishes the image, update the Helm values files that pin the RabbitMQ image tag.
7. Deploy the updated chart with the appropriate GitHub deploy workflow.

## Important Build Detail

When these files are copied into this repo, executable bits on shipped shell scripts are not always preserved.

That matters because the image depends on scripts from `prebuildfs/` and `rootfs/`, including:

- `/usr/sbin/install_packages`
- `/opt/bitnami/scripts/locales/generate-locales.sh`
- `/opt/bitnami/scripts/rabbitmq/entrypoint.sh`
- `/opt/bitnami/scripts/rabbitmq/run.sh`

If execute permissions are not restored during the Docker build, the image can fail during package installation, post-unpack setup, or container startup.

Keep the permission-restoring `chmod` steps in the Dockerfile unless the copied files in this repo are confirmed to retain the correct executable bits.

Example change for this issue:
`https://github.com/bcgov/MOTI-Message-Broker-Service/commit/1cfc0a1b72ae346208bd7db448d2a87b97deef91`

## Files To Update Together

When introducing a new managed image version, review these files together:

- `dockerfiles/<version>/debian-12/Dockerfile`
- `.github/workflows/build-push-rabbitmq-managed.yml`
- `helm/main/values-*.yaml`
- `helm/main/template.yaml`

## Verification Checklist

Before merging, verify the following:

1. `docker build` completes successfully for the target directory.
2. The managed image workflow points at the correct Dockerfile path.
3. The published image tag is available in `ghcr.io/bcgov/bitnami-rabbitmq`.
4. Helm values reference the intended RabbitMQ image tag.
5. The target environment can be deployed successfully using the appropriate deploy workflow.
