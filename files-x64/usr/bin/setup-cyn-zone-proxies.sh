#!/bin/sh

set -eu

CERT_DIR="/etc/nginx/certs"
CERT_FILE="$CERT_DIR/cyn.zone.fullchain.cer"
KEY_FILE="$CERT_DIR/cyn.zone.key"
CONF_FILE="/etc/nginx/conf.d/cyn-zone-proxies.conf"

if [ ! -f "$CERT_FILE" ] || [ ! -f "$KEY_FILE" ]; then
    echo "Missing certificate files:"
    echo "  $CERT_FILE"
    echo "  $KEY_FILE"
    exit 1
fi

mkdir -p /etc/nginx/conf.d

cat > "$CONF_FILE" <<'EOF'
server {
    listen 80;
    listen [::]:80;
    server_name git.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name git.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    location / {
        proxy_pass http://192.168.10.2:10001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name fn.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name fn.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;
    client_max_body_size 10G;
    proxy_connect_timeout 600;
    proxy_send_timeout 600;
    proxy_read_timeout 600;

    location / {
        proxy_pass http://192.168.10.2:5666;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_buffering off;
        proxy_request_buffering off;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name op.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name op.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;
    root /www;
    include conf.d/*.locations;

    location /ttyd/ {
        proxy_pass http://192.168.10.1:7681/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 3600;
        proxy_send_timeout 3600;
        proxy_buffering off;
    }

    location = / {
        return 302 /cgi-bin/luci/;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name rs.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name rs.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;

    location / {
        proxy_pass http://192.168.10.2:8888;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name rs2.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name rs2.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;

    location / {
        proxy_pass http://192.168.10.1:8888;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name r6c.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name r6c.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;

    location /ttyd/ {
        proxy_pass http://192.168.11.1:7681/;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_read_timeout 3600;
        proxy_send_timeout 3600;
        proxy_buffering off;
    }

    location / {
        proxy_pass https://192.168.11.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        proxy_ssl_verify off;
    }
}

server {
    listen 80;
    listen [::]:80;
    server_name rs3.cyn.zone;
    return 301 https://$server_name$request_uri;
}

server {
    listen 443 ssl;
    listen [::]:443 ssl;
    http2 on;
    server_name rs3.cyn.zone;

    ssl_certificate /etc/nginx/certs/cyn.zone.fullchain.cer;
    ssl_certificate_key /etc/nginx/certs/cyn.zone.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers off;

    location / {
        proxy_pass http://192.168.11.1:8888;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
EOF

nginx -t
/etc/init.d/nginx reload

echo "cyn.zone proxy config installed to $CONF_FILE"
