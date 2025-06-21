NAME=inception

all: up

up:
	docker-compose -f srcs/docker-compose.yml up -d --build

down:
	docker-compose -f srcs/docker-compose.yml down

clean:
	docker system prune -af

fclean:
	docker volume prune -f

re: fclean all

phony: 
	all build up down clean fclean re