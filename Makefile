NAME=inception
LOGIN := $(shell whoami)
DATA_PATH := /home/$(LOGIN)/data

all: up

up:
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb
	chown -R 1000:1000 $(DATA_PATH)/wordpress
	chown -R 1000:1000 $(DATA_PATH)/mariadb
	DATA_PATH=$(DATA_PATH) docker-compose --env-file srcs/.env -f srcs/docker-compose.yml up -d --build

down:
	DATA_PATH=$(DATA_PATH) docker-compose -f srcs/docker-compose.yml down

clean:
	docker system prune -af

fclean:
	docker volume prune -f

re: fclean all

phony: 
	all build up down clean fclean re