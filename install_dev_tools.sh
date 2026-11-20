#!/bin/bash
set -e

echo "=== Перевірка та встановлення DevOps інструментів ==="

# 1. Docker та Docker Compose
if ! command -v docker >/dev/null 2>&1; then
  echo "[INFO] Встановлення Docker та Docker Compose..."
  sudo apt-get update -y
  sudo apt-get install -y ca-certificates curl gnupg
  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor --yes -o /etc/apt/keyrings/docker.gpg
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  sudo apt-get update -y
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
  echo "[OK] Docker вже встановлено: $(docker --version)"
fi

# 2. Python 3.9+
if ! command -v python3 >/dev/null 2>&1; then
  echo "[INFO] Встановлення Python 3..."
  sudo apt-get update -y
  sudo apt-get install -y python3 python3-pip python3-venv
else
  echo "[OK] Python вже встановлено: $(python3 --version)"
fi

# 3. Django
if ! python3 -m django --version >/dev/null 2>&1; then
  echo "[INFO] Встановлення Django..."
  python3 -m pip install --break-system-packages django || python3 -m pip install django
else
  echo "[OK] Django вже встановлено: $(python3 -m django --version)"
fi

echo "=== Перевірку та встановлення завершено ==="
