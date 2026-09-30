#!/bin/bash

# 1. Confirmar SELinux em modo enforcing
setenforce 1
sed -i 's/^SELINUX=.*/SELINUX=enforcing/' /etc/selinux/config
echo "Estado do SELinux: $(getenforce)"

# 2. Instalar ferramenta sealert
dnf install -y setroubleshoot-server

# 3. Gerar relatorio e guardar em /var/log/seguranca.log
sealert -a /var/log/audit/audit.log > /var/log/seguranca.log
echo "Relatorio guardado em /var/log/seguranca.log"
