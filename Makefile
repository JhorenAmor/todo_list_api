.PHONY: help setup migrate seed build start stop delete status

default: help

help: ## Show help topics
	@egrep -h '\s##\s' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

setup: ##
	@cp env.template.yml .env
	@echo ".env file created!"
	@docker-compose build

rebuild: ## Rebuild `enservio-app` Stop, Build, Start application
	@docker-compose stop
	@docker-compose down
	@docker-compose build
	@docker-compose up -d

start: ## Start application container
	@docker-compose up -d
