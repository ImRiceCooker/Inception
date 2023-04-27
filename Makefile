# 쉘 스크립트 파일 경로
HOSTS_SETUP_SH=./srcs/requirements/tools/hosts.sh
VOLUME_SETUP_SH=./srcs/requirements/tools/volume.sh
FCLEAN_SETUP_SH=./srcs/requirements/tools/fclean.sh

# 도커 컴포즈 파일 경로
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose --file $(DOCKER_COMPOSE_FILE)

all: up

# 서비스 빌드, 컨테이너 실행
# -d는 백그라운드에서 실행하도록 설정
up:
	@$(VOLUME_SETUP_SH)
	@$(HOSTS_SETUP_SH)
	$(DOCKER_COMPOSE) up -d --build

# 실행중인 컨테이너를 모두 중지하고 관련된 모든 볼륨을 삭제
down:
	$(DOCKER_COMPOSE) down --volumes

# 도커 컴포즈를 실행하여 관련 볼륨 모두 삭제, 관련 이미지 모두 삭제
clean:
	sudo docker-compose -f srcs/docker-compose.yml down -v --rmi all --remove-orphans
	$(DOCKER_COMPOSE) down --rmi all --volumes

# 모든 데이터 삭제
# 사용하지 않는 모든 도커 리소스 강제 삭제
# 사용하지 않는 도커 네트워크 강제 삭제
# 사용하지 않는 도커 볼륨 강제 삭제
# FCLEAN 쉘 스크립트 실행
fclean: clean
	sudo rm -rf ${HOME}/data
	sudo docker system prune --volumes --all --force
	sudo docker network prune --force
	sudo docker volume prune --force
	@$(FCLEAN_SETUP_SH)

re:
	@make fclean
	@make all

.PHONY: all up down clean fclean re
