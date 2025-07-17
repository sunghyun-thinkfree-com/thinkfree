# 🚀 ThinkfreeOffice Docker 설치 및 실행 가이드

이 프로젝트는 Docker Compose를 통해 손쉽게 실행할 수 있습니다.
Docker 이미지는 [Amazon ECR](https://aws.amazon.com/ecr/) 에 업로드되어 있으며, 실행 스크립트를 통해 자동 설치 및 실행됩니다.

---

## ✅ 사전 준비 사항

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose v2 이상](https://docs.docker.com/compose/)
- [AWS CLI](https://aws.amazon.com/ko/cli/)

---

## 🛠 설치 및 실행 방법

### 1. 스크립트 다운로드

```bash
curl -O https://raw.githubusercontent.com/sunghyun-thinkfree-com/thinkfree/refs/heads/master/docker/tfo-install.sh
chmod +x tfo-install.sh
```

### 2. 스크립트 실행
```bash
./tfo-install.sh
```

---

## ⚙️ 스크립트 동작 내용

tfo-install.sh는 다음 작업을 자동으로 수행합니다.
- Docker 및 Docker Compose 설치 여부 확인 (필요 시 자동 설치)
- Amazon ECR 로그인
- docker-compose.yml 및 .env 템플릿 파일 다운로드
- 컨테이너 실행 (실행 시 run 옵션을 넣어서 실행 한 경우 ex) tfo-install.sh run)

---

## 🧪 실행 예시

```bash
$ ./tfo-install.sh run
🔍 Docker 설치 확인...
🚀 Docker 설치 중...
🔍 Docker Compose 설치 확인...
📦 docker-compose.yml 다운로드 중...
📋 .env 파일이 없으므로 템플릿 다운로드 중...
🔐 DockerHub 로그인 요청...
🚀 Docker Compose 실행 중... #run 옵션이 포함 된 경우에 실행 됩니다.
✅ 모든 작업이 완료되었습니다!
```

