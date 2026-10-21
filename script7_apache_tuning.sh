#!/bin/bash

# 1. Configurar KeepAlive, mod_deflate e limites de ligacoes
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

# 2. Instalar modulo SSL e utilitarios necessarios
dnf install -y mod_ssl openssl

# 3. Gerar certificado SSL para teste
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/pki/tls/private/localhost.key \
  -out /etc/pki/tls/certs/localhost.crt \
  -subj "/C=PT/CN=localhost"

# 4. Reiniciar o Apache para abrir a porta 443
systemctl restart httpd
echo "Apache otimizado e HTTPS (porta 443) ativo com sucesso."
