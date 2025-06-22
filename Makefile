NAME=inception
LOGIN := $(shell whoami)
DATA_PATH := /home/$(LOGIN)/data

all: up

up:
	mkdir -p $(DATA_PATH)/wordpress
	mkdir -p $(DATA_PATH)/mariadb
	@echo "DATA_PATH: $(DATA_PATH)" > srcs/.env.runtime
	cat srcs/.env >> srcs/.env.runtime
	docker-compose --env-file srcs/.env.runtime -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker system prune -af

fclean:
	docker volume prune -f

re: fclean all

phony: 
	all build up down clean fclean re