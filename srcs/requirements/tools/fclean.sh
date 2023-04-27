#!/bin/bash

wordpress_path=$($(pwd)/srcs/requirements/tools/get_path.sh wordpress_path)
mariadb_path=$($(pwd)/srcs/requirements/tools/get_path.sh mariadb_path)
conf=$($(pwd)/srcs/requirements/tools/get_path.sh conf)
hosts_path=$($(pwd)/srcs/requirements/tools/get_path.sh hosts_path)

# rm -rf ${wordpress_path} 명령어를 통해 Wordpress 컨테이너 내부의 파일을 삭제합니다.
# rm -rf ${mariadb_path} 명령어를 통해 MariaDB 컨테이너 내부의 데이터 파일을 삭제합니다.
rm -rf ${wordpress_path}
rm -rf ${mariadb_path}


sudo sed -i "/${conf}/d" ${hosts_path}

echo "fclean"
