#!/bin/bash
apt-get update
apt-get install -y \
ca-certificates \
curl \
gnupg \
lsb-release\
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg |  gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
$(lsb_release -cs) stable" |  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
export MYSQL_ROOT_PASSWORD=rootpass
export  PMA_HOST=mysql-service
export  PMA_PORT=3306
export  MYSQL_ROOT_PASSWORD=rootpass
touch compose.yaml
echo '
  version: "3.8"
  services:
      mysql:
        image: mysql:8.0.30-debian
        networks:
            - lamp
        expose:
            - 3306
        restart: always
        volumes:
            - mysqldata:/var/lib/mysql
            - mysqlconfig:/etc/mysql/mysql.conf.d

      phpmyadmin:
        image: phpmyadmin:5.2.0-apache
          
        networks:
            - lamp
        expose:
            - 80
        depends_on:
            - mysql
        restart: always
        labels:
            - "traefik.enable=true"
            - "traefik.http.routers.phpmyadmin.rule=Host(`internoleksii.ddns.net`)"
            - "traefik.http.routers.phpmyadmin.entrypoints=websecure"
            - "traefik.http.routers.phpmyadmin.tls.certresolver=myresolver"
        volumes:
            - phpmyadmin:/usr/share/phpMyAdmin

      traefik:
        image: "traefik:v2.8"
        container_name: "traefik"
        networks:
            - lamp
        depends_on:
            - mysql
            - phpmyadmin    
        command:
            #- "--log.level=DEBUG"
            - "--api.insecure=true"
            - "--providers.docker=true"
            - "--providers.docker.exposedbydefault=false"
            - "--entrypoints.websecure.address=:443"
            - "--certificatesresolvers.myresolver.acme.tlschallenge=true"
            - "--certificatesresolvers.myresolver.acme.email=aliapovatijpes@gmail.com"
            - "--certificatesresolvers.myresolver.acme.storage=/letsencrypt/acme.json"
        ports:
            - "443:443"
            - "8080:8080"
        volumes:
            - "./letsencrypt:/letsencrypt"
            - "/var/run/docker.sock:/var/run/docker.sock:ro"
  networks:
        lamp:

  volumes:
        mysqldata:
        mysqlconfig:
        phpmyadmin:
' >> compose.yaml
docker compose up -d