#!/bin/bash

echo "IP Publico:"
curl -s ifconfig.me
echo ""

#Configurar IP fixo automaticamente com base na ligacao ativa
INTERFACE=$(nmcli -t -f DEVICE,STATE dev | grep connected | cut -d: -f1 | head -n1)
IP_ATUAL=$(ip -4 -o addr show dev "$INTERFACE" | awk '{print $4}')
GATEWAY_ATUAL=$(ip route show default | awk '{print $3}')

echo "A aplicar IP fixo na interface $INTERFACE ($IP_ATUAL)..."
nmcli connection modify "$INTERFACE" ipv4.addresses "$IP_ATUAL" ipv4.gateway "$GATEWAY_ATUAL" ipv4.dns "1.1.1.1 8.8.8.8" ipv4.method manual
nmcli connection up "$INTERFACE"


systemctl enable --now firewalld
firewall-cmd --permanent --zone=public --add-port=22/tcp
firewall-cmd --permanent --zone=public --add-port=80/tcp
firewall-cmd --permanent --zone=public --add-port=443/tcp
firewall-cmd --reload


cat <<EOF > /root/regras_router.sh
#!/bin/bash
echo "Regras a configurar na pagina de administracao do seu Router (Port Forwarding):"
echo "WAN 80   -> IP Local: 192.168.1.100 Porta: 80"
echo "WAN 443  -> IP Local: 192.168.1.100 Porta: 443"
echo "WAN 22   -> IP Local: 192.168.1.100 Porta: 22"
EOF
chmod +x /root/regras_router.sh


ping -c 2 8.8.8.8
curl -I http://localhost
