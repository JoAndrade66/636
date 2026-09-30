#!/bin/bash

# Garante permissões de execução em todos os scripts
chmod +x *.sh

echo " A INICIAR CONFIGURAÇÃO "


echo "A executar Script 1 (LAMP)..."
./script1_lamp.sh

echo "A executar Script 2 (Segurança MariaDB)..."
./script2_mariadb.sh

echo "A executar Script 3 (Rede e Firewall)..."
./script3_rede_firewall.sh

echo "A executar Script 4 (SELinux)..."
./script4_selinux.sh

echo "A executar Script 5 (Fail2ban)..."
./script5_fail2Ban.sh

echo "A executar Script 6 (Mod_Security)..."
./script6_modsecurity.sh

echo "A executar Script 7 (Tuning Apache)..."
./script7_apache_tuning.sh

echo "A executar Script 8 (Tuning MariaDB)..."
./script8_mariadb_tuning.sh

echo "A executar Script 9 (Ajustes PHP)..."
./script9_php_tuning.sh

echo "A executar Script 10 (Atualizações e Backup)..."
./script10_backup.sh

echo "A executar Script 11 (Monitorização e NTP)..."
./script11_monitorizacao.sh


echo " CONFIGURAÇÃO CONCLUÍDA "
