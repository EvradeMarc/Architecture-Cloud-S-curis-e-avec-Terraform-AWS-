#!/bin/bash
set -e

# Mise à jour
apt update -y
apt upgrade -y

# Installation Apache + FTP client
apt install -y apache2 vsftpd curl

# Démarrage Apache
systemctl enable apache2
systemctl start apache2

# Création d'une page web personnalisée
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')

cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>$HOSTNAME</title>
</head>
<body>
    <h1>Serveur Web : $HOSTNAME</h1>
    <p>Adresse IP : $IP</p>
    <p>Load balancé via HAProxy</p>
</body>
</html>
EOF

# Droits Apache
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html
