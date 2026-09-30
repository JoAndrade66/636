#!/bin/bash

# 1. Configurar KeepAlive, mod_deflate e limites
cat <<EOF > /etc/httpd/conf.d/tuning.conf
KeepAlive On
KeepAliveTimeout 5
Timeout 60

<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css application/javascript
</IfModule>

<IfModule mpm_event_module>
    MaxRequestWorkers 150
</IfModule>
EOF

# 2. Instalar Certbot para Let's Encrypt e modulo SSL
dnf install -y mod_ssl certbot python3-certbot-apache

# 3. Configurar SSL (Tenta Let's Encrypt se houver dominio, senao gera certificado autoassinado para testes)
DOMINIO="" # Insira o dominio publico se existir

if [ -n "$DOMINIO" ]; then
    certbot --apache -d "$DOMINIO" --non-interactive --agree-tos -m root@localhost
else
    echo "A gerar certificado SSL de teste..."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
      -keyout /etc/pki/tls/private/localhost.key \
      -out /etc/pki/tls/certs/localhost.crt \
      -subj "/C=PT/CN=localhost"
fi

systemctl restart httpd
echo "Apache otimizado e SSL ativo."
