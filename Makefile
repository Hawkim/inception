DC = docker-compose -f srcs/docker-compose.yml --env-file srcs/.env

build:
	$(DC) build

up:
	$(DC) up -d

down:
	$(DC) down

re: down
	@docker system prune -fa --volumes
	$(MAKE) build
	$(MAKE) up
