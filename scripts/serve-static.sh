#!/usr/bin/env bash

declare -A params=$6     # Create an associative array
paramsTXT=""
if [ -n "$6" ]; then
   for element in "${!params[@]}"
   do
      paramsTXT="${paramsTXT}
      fastcgi_param ${element} ${params[$element]};"
   done
fi

if [ "$7" = "true" ] && [ "$5" = "7.2" ]
then configureZray="
location /ZendServer {
        try_files \$uri \$uri/ /ZendServer/index.php?\$args;
}
"
else configureZray=""
fi

block="server {
    listen ${3:-80};
    listen ${4:-443} ssl http2;
    server_name .$1;
    root \"$2\";

    index index.html index.htm

    charset utf-8;

    location ~ .*\.(?:jpg|jpeg|gif|png|ico|cur|gz|svg|svgz|mp4|ogg|ogv|webm)$
    {
        expires      7d;
    }

    location ~ .*\.(?:js|css)$
    {
        expires      7d;
    }

    location ~ .*\.(?:htm|html)$
    {
        add_header Cache-Control \"private, no-store, no-cache, must-revalidate, proxy-revalidate\";
    }

    $configureZray

    location = /favicon.ico { access_log off; log_not_found off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    access_log off;
    error_log  /var/log/nginx/$1-error.log error;

    sendfile off;
    client_max_body_size 100m;

    location ~ /\.ht {
        deny all;
    }

    ssl_certificate     /etc/nginx/ssl/$1.crt;
    ssl_certificate_key /etc/nginx/ssl/$1.key;
}
"

echo "$block" > "/etc/nginx/sites-available/$1"
ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
