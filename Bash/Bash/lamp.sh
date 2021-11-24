#!/bin/bash 
sudo apt update -y

sudo apt upgrade-y

sudo apt install nginx -y

sudo systemctl enable nginx

sudo systemctl start nginx

sudo iptables -I INPUT -p tcp --dport 80 -j ACCEPT

sudo ufw allow http

sudo chown www-data:www-data /usr/share/nginx/html -R

sudo apt install mariadb-server mariadb-client -y

sudo systemctl start mariadb

sudo systemctl enable mariadb

sudo mysql_secure_installation

sudo apt install php7.4 php7.4-fpm php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline php7.4-mbstring php7.4-xml php7.4-gd php7.4-curl -y

sudo systemctl start php7.4-fpm

sudo systemctl enable php7.4-fpm

sudo rm /etc/nginx/sites-enabled/default

sudo echo "server {
  listen 80;
  listen [::]:80;
  server_name _;
  root /usr/share/nginx/html/;
  index index.php index.html index.htm index.nginx-debian.html;

  location / {
    try_files \$uri \$uri/ /index.php;
  }

  location ~ \.php$ {
    fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    include fastcgi_params;
    include snippets/fastcgi-php.conf;
  }

 # A long browser cache lifetime can speed up repeat visits to your page
  location ~* \.(jpg|jpeg|gif|png|webp|svg|woff|woff2|ttf|css|js|ico|xml)$ {
       access_log        off;
       log_not_found     off;
       expires           360d;
  }

  # disable access to hidden files
  location ~ /\.ht {
      access_log off;
      log_not_found off;
      deny all;
  }
}" | sudo tee -a /etc/nginx/conf.d/default.conf

sudo nginx -t

sudo systemctl reload nginx


