.PHONY: help portainer-start portainer-stop

.DEFAULT: help

portainer-start:  ## Start portainer service
	docker-compose -f docker-compose.portainer.yml up -d

portainer-stop:  ## Stop portainer service
	docker-compose -f docker-compose.portainer.yml down --remove-orphans

docker-stop:  ## Stop and delete ALL docker containers
	docker stop $$(docker ps -aq) && docker rm $$(docker ps -aq)

help:  ## Display this help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
