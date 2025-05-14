# Argo-cd Deployment

Helm chart for deploying Argo CD in a Kubernetes cluster.

## Purpose

This repository provides a modular Helm-based deployment for Argo CD, using the official Helm chart from [argo-helm](https://github.com/argoproj/argo-helm) as a dependency. It focuses strictly on installing and configuring the Argo CD control plane and is intended to be environment-agnostic and easy to version and maintain.

## Structure

- `templates/`: Additional Argo CD manifest files (if needed).
- `values.yaml`: Base configuration for the Argo CD deployment.
- `Chart.yaml`: Helm chart metadata and dependency declaration.
- `Makefile`: Simplifies common Helm operations (install, upgrade, lint, etc.).

## Installation (via Helm)

```bash
git clone https://github.com/SimonaCatanoiu/argocd-k8s-deployment.git
cd argocd-k8s-deployment

# Update dependencies
helm dependency update

# Install Argo CD
helm install argo-cd . -f values.yaml --namespace argocd --create-namespace
```

## Using the Makefile

This repository includes a `Makefile` that provides convenient shortcuts for common tasks:

### 🔧 Variables

```makefile
RELEASE_NAME ?= argo-cd
NAMESPACE ?= argocd
VALUES_FILE ?= values.yaml
CHART_PATH ?= .
```

### 📦 Available Commands

```bash
make help         # Show available commands
make deps         # Update Helm chart dependencies
make install      # Install Argo CD with the configured values
make upgrade      # Upgrade an existing Argo CD release
make uninstall    # Uninstall the Argo CD release
make lint         # Lint the Helm chart
make template     # Render the Helm templates locally (dry-run)
```

### 💡 Example usage

```bash
make install
make upgrade NAMESPACE=argocd VALUES_FILE=values.yaml
```

## Notes

- This repository **does not** contain any `Application` or `ApplicationSet` resources.
