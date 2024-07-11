# -- General
SHELL := /bin/bash
NAME_URL=https://datasets.imdbws.com/name.basics.tsv.gz
TITLE_URL=https://datasets.imdbws.com/title.basics.tsv.gz

# ==============================================================================
# RULES

default: help

# -- Files
name.basics.tsv.gz:
	curl -O $(NAME_URL)

title.basics.tsv.gz:
	curl -O $(TITLE_URL)

# -- Phony
bootstrap: ## bootstrap the project
bootstrap: \
  name.basics.tsv.gz \
  title.basics.tsv.gz \
	install
.PHONY: bootstrap

install: ## install project dependencies
	poetry install
.PHONY: install

lint: ## lint all sources
lint: \
	lint-black \
	lint-ruff \
  lint-mypy
.PHONY: lint

lint-black: ## lint python sources with black
	@echo 'lint:black started…'
	poetry run black .
.PHONY: lint-black

lint-black-check: ## check python sources with black
	@echo 'lint:black check started…'
	poetry run black --check .
.PHONY: lint-black-check

lint-ruff: ## lint python sources with ruff
	@echo 'lint:ruff started…'
	poetry run ruff check .
.PHONY: lint-ruff

lint-ruff-fix: ## lint and fix python sources with ruff
	@echo 'lint:ruff-fix started…'
	poetry run ruff check --fix .
.PHONY: lint-ruff-fix

lint-mypy: ## lint python sources with mypy
	@echo 'lint:mypy started…'
	poetry run mypy .
.PHONY: lint-mypy

# -- Misc
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help
