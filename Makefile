VERSION=$(or $(shell git describe --tags --always), latest)

ARTIFACTORY ?= ""

.ONESHELL:
.PHONY: run fmt prepare help

fmt: ## Format the code using pre-commit
	pre-commit run --all

prepare: ## Prepare the package and application dependencies
	cd /package && poetry install

help: ## Print help with command name and comment for each target
	@echo "Available targets:"
	@awk '/^[a-zA-Z\-_0-9]+:/ { \
		helpMessage = match(lastLine, /^# (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 1, length($$1)-1); \
			helpComment = substr(lastLine, RSTART + 2, RLENGTH - 2); \
			printf "  %-20s %s\n", helpCommand, helpComment; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)
