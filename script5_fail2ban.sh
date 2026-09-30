#!/bin/bash

# 1. Instalar Fail2ban via EPEL
dnf install -y epel-release
dnf install -y fail2ban

# 2. Configurar jail.local com bloqueio apos 3 tentativas falhadas
cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
bantime  = 1h
findtime = 10m
maxretry = 3
destemail = root@localhost
action = %(action_mwl)s

[sshd]
enabled = true
port = 22

[apache-auth]
enabled = true
port = 80,443
EOF

# 3. Iniciar servico
systemctl enable --now fail2ban
fail2ban-client status
