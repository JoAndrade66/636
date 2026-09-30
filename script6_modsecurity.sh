#!/bin/bash

# 1. Instalar modulo e regras OWASP
dnf install -y mod_security mod_security_crs

# 2. Ativar o motor de bloqueio
sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/' /etc/httpd/conf.d/mod_security.conf
systemctl restart httpd

# 3. Teste de ataque simulado (SQL Injection)
echo "--- Teste SQL Injection ---"
curl -s -o /dev/null -w "%{http_code}\n" "http://localhost/info.php?id=1%20OR%201=1"

# 4. Teste de ataque simulado (Cross-Site Scripting - XSS)
echo "--- Teste XSS ---"
curl -s -o /dev/null -w "%{http_code}\n" "http://localhost/info.php?xss=<script>alert(1)</script>"

echo "(O codigo 403 confirma que o ataque foi bloqueado com sucesso)"
