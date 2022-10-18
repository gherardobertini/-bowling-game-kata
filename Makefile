:PHONY: *
.DEFAULT_GOAL := help

help: ## it shows help menu
	@awk 'BEGIN {FS = ":.*#"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z0-9_-]+:.*?#/ { printf "  \033[36m%-27s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

dbash: ## it lanches bash in container
	docker compose exec web bash

down: ## it gets down containers
	docker compose down

down-v: ## it gets down containers and removes volumes
	docker compose down -v

dt: ## it launches tests using container
	docker compose exec web php vendor/bin/phpunit

up: ## it launches containers
	docker compose up -d