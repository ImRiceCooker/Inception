#!/bin/sh

# RSA 키 길이를 4096에서 2048로 줄입니다. 2048 비트도 충분히 안전하며, 더 작은 키 길이는 작업을 더 빠르게 해 줍니다.
# -subj 옵션의 인수를 간단하게 하여 코드 가독성을 높입니다. 이 인수는 인증서 내에 포함될 서브젝트(subject) 정보를 나타냅니다.
# -addext 옵션을 추가하여 대체 이름(alternative name)을 추가합니다. 이는 최신 웹 브라우저에서 필수적인 기능이며, 도메인 이름이 다른 경우에도 인증서가 유효하도록 합니다.
# 인증서 유효 기간(-days)을 30일에서 365일로 늘립니다. 인증서는 서버 인증을 위한 기능이므로 유효 기간이 짧을 경우 매번 갱신해야 합니다. 365일은 일반적으로 사용하는 인증서의 유효 기간입니다.

openssl req -newkey rsa:2048 -nodes -keyout "/etc/ssl/${INTRA_ID}.42.fr.key" \
    -x509 -days 365 -out "/etc/ssl/${INTRA_ID}.42.fr.crt" \
    -subj "/CN=${INTRA_ID}.42.fr" -addext "subjectAltName=DNS:${INTRA_ID}.42.fr" \
    2>/dev/null

echo "nginx ready, port is 443"

# 이 코드는 Nginx 서버를 실행하는 명령어 중 하나입니다. 
# Nginx를 실행하는 데몬(demon) 프로세스를 백그라운드에서 실행하지 않고, 프로세스가 종료되지 않도록 데몬 모드(daemon mode)를 해제하여 실행하는 것입니다. 
# 이렇게 함으로써 Docker 컨테이너에서 Nginx 서버가 실행됩니다.

exec nginx -g 'daemon off;'
