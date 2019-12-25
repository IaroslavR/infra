include .env

.EXPORT_ALL_VARIABLES: ;

.PHONY: help swarm-init portainer-swarm portainer-start portainer-stop

.DEFAULT: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

swarm-init:  ## Init docker swarm
	docker swarm init

swarm-start:  ## Start docker swarm stack
	docker stack deploy -c docker-compose.swarm.yml ${COMPOSE_PROJECT_NAME}

portainer-start:  ## Start portainer service
	docker-compose -f docker-compose.portainer.yml up -d

portainer-stop:  ## Stop portainer service
	docker-compose -f docker-compose.portainer.yml down --remove-orphans

swarm-stop:  ## Stop docker swarm stack
	docker stack rm ${COMPOSE_PROJECT_NAME}

docker-stop:  ## Stop and delete ALL docker containers
	docker stop $$(docker ps -aq) && docker rm $$(docker ps -aq)

infra-init: ## Init Terraform infrastructure
	cd terraform/aws && terragrunt init
	cd terraform/google && terragrunt init

infra-test: ## Test Terraform infrastructure
	cd terraform/aws && terragrunt plan
	cd terraform/google && terragrunt plan

infra-deploy:
	cd terraform/aws && terragrunt apply
	cd terraform/google && terragrunt apply

infra-print:  ## Print Terraform infrastructure output variables
	cd terraform/aws && terragrunt output
	cd terraform/google && terragrunt output