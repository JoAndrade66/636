#!/bin/bash

# 1. Atualizacao automatica do sistema
dnf update -y

# 2. Criar diretorio de backup
mkdir -p /backups
DATA=$(date +%Y%m%d_%H%M)

# 3. Backup do website /var/www/html
tar -czf "/backups/site_$DATA.tar.gz" -C /var/www html

# 4. Backup e compressao das bases de dados MariaDB
mysqldump --all-databases -u root -p"atec123" | gzip > "/backups/db_$DATA.sql.gz"

echo "Backups criados com sucesso em /backups:"
ls -lh /backups
