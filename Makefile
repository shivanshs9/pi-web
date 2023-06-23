DOCKER_COMPOSE_ARGS := --env-file ../.env
DOCKER_COMPOSE_UP = docker-compose $(DOCKER_COMPOSE_ARGS) up -d

.PHONY: photoprism
photoprism:
	cd $@ && $(DOCKER_COMPOSE_UP)

.PHONY: db
db:
	cd $@ && $(DOCKER_COMPOSE_UP)

encrypt:
	sops --encrypt ./app/secret.ignore.yml > ./app/secret.yml
