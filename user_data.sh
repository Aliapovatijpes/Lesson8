#!/bin/bash
apt-get update
apt-get install -y \
ca-certificates \
curl \
gnupg \
lsb-release
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
export MYSQL_ROOT_PASSWORD=rootpass
export PMA_HOST=mysql-service
export PMA_PORT=3306
export MYSQL_ROOT_PASSWORD=rootpass
touch compose.yaml
echo 'version: "3.8"
services:
    mysql:
        image: mysql:8.0.30-debian
        networks:
            - lamp
        expose:
            - 3306
        restart: always
    phpmyadmin:
        image: phpmyadmin:5.2.0-apache
        networks:
            - lamp
        ports:
            - "80:80"
        depends_on:
            - mysql
        restart: always
networks:
        lamp:
' >> compose.yaml
pwd >> pwd.txt
ls >> ls.txt
docker compose version >> dversion.txt
docker compose up -d
docker compose version >> dversion.txt