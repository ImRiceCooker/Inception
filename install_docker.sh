# 시스템 패키지 관리자가 패키지 저장소에서 최신 정보를 가져와 로컬 패키지 데이터베이스를 업데이트
sudo apt-get update

# ca-certificates : 인증서를 관리하기 위한 패키지입니다. HTTPS 프로토콜을 사용하는 웹 사이트와 통신하는 데 필요한 인증서를 관리하며, HTTPS 프로토콜을 사용하는 애플리케이션에서 인증서를 인식하도록 합니다.
# curl : URL을 통해 데이터를 전송하거나 받는 도구입니다. curl을 사용하여 웹 서버에서 파일을 다운로드하거나 REST API와 상호 작용할 수 있습니다.
# gnupg : GNU Privacy Guard의 약어입니다. GPG는 개인 정보를 암호화하고 디지털 서명을 생성하는 데 사용됩니다. 이를 통해 전자 메일 메시지 및 파일을 안전하게 전송하거나 다운로드할 수 있습니다.
# lsb-release : 시스템 정보를 포함하는 파일입니다. 이 파일은 현재 운영체제의 이름, 버전 및 호스트 이름 등과 같은 시스템 정보를 검색하는 데 사용됩니다.

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# apt 관리자에서 사용하는 공개 키를 저장하기 위한 디렉토리를 생성하는데 사용.
# 시스템에서 패키지 관리를 수행하는 데 필요한 디렉토리를 생성하여 시스템이 패키지를 정상적으로 설치하고 업데이트할 수 있도록 보장합니다.
sudo mkdir -p /etc/apt/keyrings

# 도커의 공식 GPG 키를 다운로드 하고 파일에 저장, 
# 위 명령을 실행하면 Docker 패키지를 다운로드하고 설치하는 데 필요한 공식 GPG 키가 /etc/apt/keyrings/docker.gpg 파일에 저장됩니다.
# 이 파일은 apt 패키지 관리자가 Docker 패키지 저장소의 신뢰성을 검증하는 데 사용됩니다.
# Docker 패키지 저장소의 신뢰성을 검증하는 이유는 보안과 안정성을 보장하기 위해서입니다.
# Docker에서 실행되는 애플리케이션에 필요한 다양한 라이브러리, 프레임워크, 언어 런타임 등을 제공합니다. 
# 그러나 이러한 패키지 중 일부는 악성 코드나 보안 취약점이 포함될 수도 있습니다. 
# 이러한 패키지를 설치하면 시스템이 해킹될 위험이 있으며, 데이터 유출 등의 보안 문제가 발생할 수 있습니다.

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker jeongkpa

# 위의 명령은 /etc/hosts 파일에 jeongkpa.42.fr 도메인을 로컬 IP 주소(127.0.0.1)와 매핑하여 추가하는 것입니다.
# 이 명령을 실행하면 /etc/hosts 파일에 127.0.0.1 jeongkpa.42.fr가 추가됩니다. 
# 이제 브라우저에서 http://jeongkpa.42.fr을 열면 로컬에서 웹 서버가 실행 중인 것처럼 페이지를 볼 수 있습니다.

echo '127.0.0.1 jeongkpa.42.fr' | sudo tee -a /etc/hosts

sudo reboot
