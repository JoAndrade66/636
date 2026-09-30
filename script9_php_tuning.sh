#!/bin/bash

PHP_INI="/etc/php.ini"

# Aplicar valores no php.ini
sed -i 's|^;*date.timezone =.*|date.timezone = Europe/Lisbon|' "$PHP_INI"
sed -i 's|^;*upload_max_filesize =.*|upload_max_filesize = 20M|' "$PHP_INI"
sed -i 's|^;*post_max_size =.*|post_max_size = 25M|' "$PHP_INI"
sed -i 's|^;*memory_limit =.*|memory_limit = 256M|' "$PHP_INI"

# Reiniciar Apache para carregar novo PHP
systemctl restart httpd

# Validar configuracoes
php -r 'echo "Timezone: ".ini_get("date.timezone")."\n";'
php -r 'echo "Upload Max: ".ini_get("upload_max_filesize")."\n";'
php -r 'echo "Post Max: ".ini_get("post_max_size")."\n";'
php -r 'echo "Memory Limit: ".ini_get("memory_limit")."\n";'
