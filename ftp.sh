#!/bin/bash
set -e

# Mise à jour
apt update -y
apt upgrade -y

# Installation FTP
apt install -y vsftpd

# Sauvegarde config
cp /etc/vsftpd.conf /etc/vsftpd.conf.bak

# Création utilisateur FTP
useradd -m ftpuser
echo "ftpuser:ftpuser" | chpasswd

# Dossier FTP
mkdir -p /home/ftpuser/ftp
chown -R ftpuser:ftpuser /home/ftpuser
chmod -R 755 /home/ftpuser

# Configuration vsftpd
cat <<EOF > /etc/vsftpd.conf
listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
chroot_local_user=YES
allow_writeable_chroot=YES

pasv_enable=YES
pasv_min_port=40000
pasv_max_port=40100

local_root=/home/ftpuser/ftp
EOF

# Redémarrage FTP
systemctl enable vsftpd
systemctl restart vsftpd
