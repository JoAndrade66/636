#!/bin/bash

# 1. Calcular 60% da RAM total em MB
RAM_TOTAL_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_60_MB=$(( RAM_TOTAL_KB * 60 / 100 / 1024 ))

# 2. Inserir parametros no /etc/my.cnf
cat <<EOF >> /etc/my.cnf

# Otimizacoes pedidas
[mysqld]
innodb_buffer_pool_size = ${RAM_60_MB}M
innodb_log_file_size = 256M
max_connections = 100
query_cache_size = 32M
EOF

# 3. Reiniciar o servico e validar
systemctl restart mariadb
mariadb -e "SHOW VARIABLES LIKE 'innodb_buffer_pool_size';"
mariadb -e "SHOW VARIABLES LIKE 'max_connections';"
