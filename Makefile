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

# -- Misc
help:
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
.PHONY: help
