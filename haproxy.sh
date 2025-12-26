#!/bin/bash
set -e

# Mise à jour du système
apt update -y
apt upgrade -y

# Installation HAProxy
apt install -y haproxy curl

# Sauvegarde config par défaut
cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bak

# Configuration HAProxy
cat <<EOF > /etc/haproxy/haproxy.cfg
global
    log /dev/log local0
    log /dev/log local1 notice
    daemon
    maxconn 2048

defaults
    log global
    mode http
    option httplog
    option dontlognull
    timeout connect 5s
    timeout client  50s
    timeout server  50s

frontend http_front
    bind *:80
    default_backend web_servers

backend web_servers
    balance roundrobin
    option httpchk
    server web1 10.0.2.10:80 check
    server web2 10.0.2.11:80 check
EOF

# Activation et redémarrage
systemctl enable haproxy
systemctl restart haproxy
