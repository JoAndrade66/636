#!/bin/bash

# 1. Definir credenciais configuradas no Script 2
DB_PASS="atec123"

# 2. Calcular 60% da RAM total do sistema em MB
RAM_TOTAL_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_60_MB=$(( RAM_TOTAL_KB * 60 / 100 / 1024 ))

# 3. Criar ficheiro de configuracao dedicado em /etc/my.cnf.d/
cat <<EOF > /etc/my.cnf.d/tuning.cnf
[mysqld]
innodb_buffer_pool_size = ${RAM_60_MB}M
innodb_log_file_size = 256M
max_connections = 100
query_cache_size = 32M
EOF

# 4. Reiniciar o MariaDB para carregar os novos parametros
systemctl restart mariadb

# 5. Validar os parametros em execucao na base de dados
echo "=== Validacao dos Parametros de Memoria e Conexoes ==="
mariadb -u root -p"${DB_PASS}" -e "SHOW VARIABLES LIKE 'innodb_buffer_pool_size';"
mariadb -u root -p"${DB_PASS}" -e "SHOW VARIABLES LIKE 'max_connections';"
