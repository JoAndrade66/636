#!/bin/bash


dnf install -y httpd php php-mysqlnd mariadb-server curl


systemctl enable --now httpd
systemctl enable --now mariadb


echo "<?php phpinfo(); ?>" > /var/www/html/info.php


echo "--- Teste Local ---"
curl -I http://localhost/info.php

echo "--- Teste IP Público ---"
IP_PUB=$(curl -s ifconfig.me)
echo "IP Publico detetado: $IP_PUB"
curl -I "http://$IP_PUB/info.php"
