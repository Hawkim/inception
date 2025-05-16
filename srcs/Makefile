NAME=inception

all: build up

build:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env build

up:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env up -d

down:
	docker-compose -f srcs/docker-compose.yml --env-file srcs/.env down

clean: down
	docker system prune -fa --volumes

re: clean all
