.DEFAULT_GOAL:=help

.EXPORT_ALL_VARIABLES:

ifndef VERBOSE
.SILENT:
endif

# set default shell
SHELL=/usr/bin/env bash -o pipefail -o errexit

TAG ?= $(shell cat TAG)
POETRY_HOME ?= ${HOME}/.local/share/pypoetry
POETRY_BINARY ?= ${POETRY_HOME}/venv/bin/poetry
POETRY_VERSION ?= 1.3.2

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: show-version
show-version:  ## Display version
	echo -n "${TAG}"

.PHONY: build
build: ## Build quasar-first package
	echo "[build] Build quasar-first package."
	${POETRY_BINARY} build

.PHONY: install
install:  ## Install quasar-first with poetry
	@build/install.sh

.PHONY: image
image:  ## Build quasar-first image
	@build/image.sh

.PHONY: metrics
metrics: install ## Run quasar-first metrics checks
	echo "[metrics] Run quasar-first PEP 8 checks."
	${POETRY_BINARY} run flake8 --select=E,W,I --max-line-length 88 --import-order-style pep8 --statistics --count quasar_first
	echo "[metrics] Run quasar-first PEP 257 checks."
	${POETRY_BINARY} run flake8 --select=D --ignore D301 --statistics --count quasar_first
	echo "[metrics] Run quasar-first pyflakes checks."
	${POETRY_BINARY} run flake8 --select=F --statistics --count quasar_first
	echo "[metrics] Run quasar-first code complexity checks."
	${POETRY_BINARY} run flake8 --select=C901 --statistics --count quasar_first
	echo "[metrics] Run quasar-first open TODO checks."
	${POETRY_BINARY} run flake8 --select=T --statistics --count quasar_first tests
	echo "[metrics] Run quasar-first black checks."
	${POETRY_BINARY} run black --check quasar_first

.PHONY: unit-test
unit-test: install ## Run quasar-first unit tests
	echo "[unit-test] Run quasar-first unit tests."
	${POETRY_BINARY} run pytest tests/unit

.PHONY: integration-test
integration-test: install ## Run quasar-first integration tests
	echo "[unit-test] Run quasar-first integration tests."
	${POETRY_BINARY} run pytest tests/integration

.PHONY: coverage
coverage: install  ## Run quasar-first tests coverage
	echo "[coverage] Run quasar-first tests coverage."
	${POETRY_BINARY} run pytest --cov=quasar_first --cov-fail-under=90 --cov-report=xml --cov-report=term-missing tests

.PHONY: test
test: unit-test integration-test  ## Run quasar-first tests

.PHONY: docs
docs: install ## Build quasar-first documentation
	echo "[docs] Build quasar-first documentation."
	${POETRY_BINARY} run sphinx-build docs site

.PHONY: mypy
mypy: install  ## Run quasar-first mypy checks
	echo "[mypy] Run quasar-first mypy checks."
	${POETRY_BINARY} run mypy quasar_first

.PHONY: dev-env
dev-env: image ## Start a local Kubernetes cluster using minikube and deploy application
	@build/dev-env.sh

.PHONY: clean
clean: ## Remove .cache directory and cached minikube
	minikube delete && rm -rf ~/.cache ~/.minikube
