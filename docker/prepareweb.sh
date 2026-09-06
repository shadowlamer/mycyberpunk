#!/bin/sh

mkdir -p ${CERTDIR}

cat << EOF > ${CERTDIR}/config
[req]
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
C = RU
CN = ${SITE_URL}
emailAddress = ${MNT_EMAIL}
EOF

openssl req -batch -x509 -nodes -days 365 -newkey rsa:2048 -keyout ${CERTDIR}/privkey.pem -out ${CERTDIR}/certificate.pem -config ${CERTDIR}/config

cat << EOF > /etc/nginx/conf.d/default.conf
server {
    listen 80;
    index index.html;
    server_name ${SITE_URL};
    error_log  /var/log/nginx/error.log;

    location / {
        root ${HTMLDIR};
    }
}

server {
    listen 443 ssl;
    index index.html;
    server_name ${SITE_URL};
    error_log  /var/log/nginx/error.log;
    ssl_certificate ${CERTDIR}/certificate.pem;
    ssl_certificate_key ${CERTDIR}/privkey.pem;
     location / {
        root ${HTMLDIR};
    }
 }
EOF
