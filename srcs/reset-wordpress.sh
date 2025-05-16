#!/bin/sh

echo "🚨 Resetting WordPress database and files..."

docker exec -i mariadb sh -c \
  "mysql -u root -padmin -e 'DROP DATABASE IF EXISTS wordpress_db; CREATE DATABASE wordpress_db;'"

# Clear persistent volume
echo "🧨 Deleting local volume content..."
sudo rm -rf /home/kali/data/wordpress/*

echo "🔁 Restarting containers..."
docker-compose -f srcs/docker-compose.yml down
docker-compose -f srcs/docker-compose.yml up -d --build

echo "📺 Following WordPress logs..."
sleep 3
docker logs -f wordpress
