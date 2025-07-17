#!/bin/bash

set -e

# === 설정 영역 ===
REPO_URL="https://raw.githubusercontent.com/your-org/your-repo/main/docker-compose.yml"
ENV_TEMPLATE_URL="https://raw.githubusercontent.com/your-org/your-repo/main/.env.example"
ENV_FILE=".env"
USE_ECR=false      # ECR 사용 시 true 로 설정
ECR_REGION="ap-northeast-2"
ECR_REPO_URL="<account_id>.dkr.ecr.ap-northeast-2.amazonaws.com"
# =================

echo "🔍 Docker 설치 확인..."
if ! command -v docker &> /dev/null; then
    echo "🚀 Docker 설치 중..."
    sudo apt update
    sudo apt install -y docker.io
    sudo systemctl enable --now docker
fi

echo "🔍 Docker Compose 설치 확인..."
if ! docker compose version &> /dev/null; then
    echo "🚀 Docker Compose 설치 중..."
    sudo curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
        -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

# Docker 데몬 재시작 (권한 이슈 방지)
sudo systemctl restart docker

echo "📦 docker-compose.yml 다운로드 중..."
curl -O "$REPO_URL"

echo "📦 .env 설정파일 확인..."
if [ ! -f "$ENV_FILE" ]; then
    echo "📋 .env 파일이 없으므로 템플릿 다운로드 중..."
    curl -o "$ENV_FILE" "$ENV_TEMPLATE_URL"
fi

echo "🔐 AWS ECR 로그인 중..."
aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin $ECR_REPO_URL

if [ "$1" = "run" ]; then
    echo "🚀 Docker Compose 실행 중..."
    docker compose up -d
fi

echo "✅ 모든 작업이 완료되었습니다!"
