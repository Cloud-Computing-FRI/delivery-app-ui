Web frontend for customers to browse restaurants, place orders, and track deliveries; talks to the microservices via REST.

## CI/CD

A push to `main` deploys to staging, and an approved manual run deploys to prod
(`.github/workflows/ci-cd.yml`). The required GitHub secrets, how to retrieve
them with the Azure CLI, and how to manage the cluster with `kubectl` live on the
organization profile:
https://github.com/Cloud-Computing-FRI/.github

Specific to this repository. The workflow logs in to Azure with OIDC under the
subject `repo:Cloud-Computing-FRI/delivery-app-ui:environment:<staging|prod>`.
This service has no database; it proxies `/api/...` to the backend Services by
their stable names in the same namespace.
