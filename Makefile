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

traefik:
	docker stack deploy infra --compose-file=stacks/docker-compose.traefik.yaml

portainer:
	docker stack deploy infra --compose-file=stacks/docker-compose.portainer.yaml

socket:
	docker stack deploy infra --compose-file=stacks/docker-compose.docker-proxy.yaml

prometeus:
	docker stack deploy infra --compose-file=stacks/docker-compose.prometeus.yaml

test-server:
	docker stack deploy test --compose-file=stacks/docker-compose.test.yaml

local-swarm: portainer traefik prometeus socket

local-infra:
	cd terraform/local && terragrunt apply -auto-approve

local:  local-infra local-swarm  ## deploy local stack

local-destroy:  ## delete local stack
	docker stack rm infra
	cd terraform/local && terragrunt destroy -auto-approve
