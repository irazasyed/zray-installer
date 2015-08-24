#!/bin/bash

#------------------------------------------------------------------------------
#                       Z-Ray Installer for Laravel Homestead
#------------------------------------------------------------------------------
#
# Project URL:  https://github.com/irazasyed/zray-installer
#

#
# Helper function to output in color
#
coloredEcho() {
    tput setaf $2;
    echo "$1";
    tput sgr0;
}

info() {
    coloredEcho "$1" 2;
}

note() {
    coloredEcho "$1" 3;
}

info "****************************"
info " Welcome to Z-Ray Installer"
info "****************************"

cd ~

# Download Z-Ray & Extract Z-Ray Files.
info "Downloading and Installing Z-Ray."
wget http://downloads.zend.com/zray/1208/zray-php5.6-Ubuntu-14.04-x86_64.tar.gz;
sudo tar xfz zray-php5.6-Ubuntu-14.04-x86_64.tar.gz -C /opt;

rm -rf zray*
note "Done.."
echo ""

info "Adding Z-Ray Config."
sudo touch /etc/nginx/conf.d/zray.conf
sudo tee -a /etc/nginx/conf.d/zray.conf >/dev/null <<EOF
server {
  listen 10081 default_server;
  server_name _;
  server_name_in_redirect off;
  root /opt/zray/gui/public;
  index index.php index.html index.htm;
  location ~ ^/ZendServer/(.+)$ {
    try_files /\$1 /index.php?\$args;
  }
  location / {
    try_files \$uri \$uri/ /index.php\$is_args\$args;
  }
  location ~ \.php$ {
    fastcgi_pass unix:/var/run/php5-fpm.sock;
    fastcgi_index index.php;
    include fastcgi_params;
  }
}
EOF
note "Done"
echo ""

info "Creating Symlinks to PHP configurations."
sudo ln -sf /opt/zray/zray.ini /etc/php5/cli/conf.d/zray.ini
sudo ln -sf /opt/zray/zray.ini /etc/php5/fpm/conf.d/zray.ini
note "Done"
echo ""

info "Setting Permissions."
sudo chown -R vagrant:vagrant /opt/zray
note "Done"
echo ""

info "Restarting Nginx and PHP."
sudo service nginx restart
sudo service php5-fpm restart
note "Done"
echo ""

info "Verify that the Z-Ray was installed successfully:"
php -v | grep "Zend Server Z-Ray";
note "Make sure the above line says \"with Zend Server Z-Ray v8.5.0 ...\" If it's blank, then install was not successful!"
echo ""

info "***********************************"
info "You should now edit homestead file"
info "and add the following under cpus directive:"
note "ports:"
note "    - send: 10081"
note "      to: 10081"
info "Then provision it by firing the command:"
note "homestead provision"
info "***********************************"
echo ""

note "Happy Coding :)"
note "This installer is brought to you by @irazasyed - https://github.com/irazasyed"