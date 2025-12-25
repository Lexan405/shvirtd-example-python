#!/bin/bash
set -e

echo "Устанавливаем зависимости..."
sudo apt update
sudo apt install -y git docker-compose

echo "Клонируем репозиторий..."
git clone https://github.com/Lexan405/shvirtd-example-python.git "$HOME/shvirtd-example-python"

echo "Переходим в директорию проекта..."
cd "$HOME/shvirtd-example-python"

echo "Запускаем приложение..."
docker compose up -d --build

echo "Готово! Приложение запущено."
