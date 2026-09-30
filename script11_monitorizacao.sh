#!/bin/bash

# 1. Sincronizacao horaria via NTP
dnf install -y chrony
systemctl enable --now chronyd
chronyc sources

# 2. Analise de logs do Apache e de seguranca SSH
echo "=== Ultimos Erros Apache ==="
tail -n 10 /var/log/httpd/error_log 2>/dev/null

echo "=== Tentativas de Falha SSH ==="
grep "Failed password" /var/log/secure | tail -n 10 2>/dev/null

# 3. Alerta por email se existirem falhas
FALHAS=$(grep -c "Failed password" /var/log/secure 2>/dev/null || echo 0)

if [ "$FALHAS" -gt 5 ]; then
    echo "Alerta: $FALHAS falhas de login detetadas no servidor." | mail -s "Alerta de Seguranca" root@localhost 2>/dev/null || echo "Falhas encontradas no /var/log/secure: $FALHAS"
fi
