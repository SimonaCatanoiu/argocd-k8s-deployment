# Variables
RELEASE_NAME ?= argo-cd
NAMESPACE ?= argocd

# Values file
VALUES_FILE ?= values.yaml
# Chart path
CHART_PATH ?= .

# Default target
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make install        - Install Argo CD in the cluster"
	@echo "  make upgrade        - Upgrade Argo CD release"
	@echo "  make uninstall      - Uninstall Argo CD release"
	@echo "  make deps           - Update Helm chart dependencies"
	@echo "  make lint           - Lint the Helm chart"
	@echo "  make template       - Render Helm templates locally"

.PHONY: deps
deps:
	helm dependency update $(CHART_PATH)

.PHONY: install
install: deps
	helm install $(RELEASE_NAME) $(CHART_PATH) \
		--namespace $(NAMESPACE) --create-namespace \
		-f $(VALUES_FILE)

.PHONY: upgrade
upgrade: deps
	helm upgrade $(RELEASE_NAME) $(CHART_PATH) \
		--namespace $(NAMESPACE) \
		-f $(VALUES_FILE)

.PHONY: uninstall
uninstall:
	helm uninstall $(RELEASE_NAME) --namespace $(NAMESPACE)

.PHONY: lint
lint:
	helm lint $(CHART_PATH)

.PHONY: template
template:
	helm template $(RELEASE_NAME) $(CHART_PATH) -f $(VALUES_FILE)
