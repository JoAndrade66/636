# 636
# Automatização de Servidor Web (CentOS 10)

Scripts em Bash para instalar, configurar e proteger automaticamente um servidor LAMP (Apache, MariaDB e PHP) em CentOS 10

---

## Como Executar

Numa máquina CentOS 10 com utilizador `root`, basta executar:

```bash
dnf install -y git
git clone [https://github.com/JoAndrade66/636.git](https://github.com/JoAndrade66/636.git)
cd 636
chmod +x *.sh
./executar_tudo.sh
