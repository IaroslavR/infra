include .env

.EXPORT_ALL_VARIABLES: ;

.PHONY: help swarm-init portainer-swarm portainer-start portainer-stop

.DEFAULT: help

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

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

local-swarm:
	cd terraform/local/stacks && \
		docker stack deploy infra --compose-file=docker-compose.traefik.yaml
	cd terraform/local/stacks && \
    	docker stack deploy infra --compose-file=docker-compose.portainer.yaml

local-infra:
	cd terraform/local && terragrunt apply -auto-approve

local:  local-infra local-swarm  ## deploy local stack

local-destroy:  ## delete local stack
	docker stack rm infra
	cd terraform/local && terragrunt destroy -auto-approve
