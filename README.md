Web frontend for customers to browse restaurants, place orders, and track deliveries; talks to the microservices via REST.

## Required GitHub secrets

The workflow (`.github/workflows/ci-cd.yml`) lints the chart on every push and
pull request, deploys to staging on a push to main, and deploys to prod on a
manual run. Set these under **Settings > Secrets and variables > Actions**:

| Secret | Purpose |
| --- | --- |
| `DOCKERHUB_USERNAME` | Docker Hub username (also the image namespace) |
| `DOCKERHUB_TOKEN` | Docker Hub access token (push) |
| `AZURE_CLIENT_ID` | Client ID of the user-assigned managed identity (OIDC) |
| `AZURE_TENANT_ID` | Azure tenant ID |
| `AZURE_SUBSCRIPTION_ID` | Azure subscription ID |
| `AKS_RESOURCE_GROUP` | Resource group holding the AKS cluster |
| `AKS_CLUSTER_NAME` | AKS cluster name |

Azure login uses OIDC, so no client secret is stored. The managed identity needs
one federated credential per environment, with subject
`repo:Cloud-Computing-FRI/delivery-app-ui:environment:<staging|prod>`.

The UI has no database. It proxies `/api/...` to the backend Services by their
stable names in the same namespace.

## Prod approval gate

A push to main deploys to staging automatically. A prod release is a manual run
of the workflow. Make it a reviewed decision by opening **Settings >
Environments > prod** and adding yourself or the team under **Required
reviewers**. A prod run then pauses and waits for an approval before it
proceeds.
