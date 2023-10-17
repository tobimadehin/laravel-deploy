# Firewall rules configuration
ufw default deny incoming
ufw default allow outgoing
ufw allow 22
ufw allow 80
ufw allow 443
echo "yes" | sudo ufw enable
ufw status

# Install php and extensions
apt update
apt install php8.1 -y
apt install php-curl php-mbstring php-xml php-fpm php-mysql -y

# Install mysql (MariaDB is an open source, drop-in MySQL replacement).
apt install mariadb-server -y

# Create a 1 GB swap file (adjust as needed to get about 2 GB total swap + RAM)
dd if=/dev/zero of=/swapfile bs=1M count=1024 status=progress
chmod 0600 /swapfile
mkswap /swapfile
swapon /swapfile

# Install composer
apt install curl unzip php-cli -y
curl https://getcomposer.org/installer -o composer-setup.php
HASH=$(curl -sS https://composer.github.io/installer.sig)
php -r "if (hash_file('SHA384', 'composer-setup.php') === '${HASH}') { \
  echo 'Installer verified'; } else { echo 'Installer corrupt'; \
  unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Install composer packages
cd /var/www/laravel_app
echo "yes" | composer install --optimize-autoloader --no-dev

# Configure .env
touch .env
### copy the .env file
php artisan key:generate

# Migrate app database
php artisan migrate
php artisan db:seed

# Optimizations
php artisan route:cache
php artisan config:cache
php artisan view:cache

# Make www-data the owning group of your app's files
cd ~/
chgrp -R www-data /var/www/laravel_app
cd /var/www/laravel_app
chmod -R g=rwX storage/ bootstrap/cache/

# Remove any possible apache installation
systemctl stop apache2.service
systemctl disable apache2.service
apt purge apache2* -y
apt autoremove -y


# Install nginx
cd ~/
apt install nginx -y
systemctl enable --now nginx.service
touch /etc/nginx/sites-available/laravel_app
# nano /etc/nginx/sites-available/laravel_app
cd /etc/nginx/sites-enabled
ln -s ../sites-available/laravel_app laravel_app
sudo rm default
sudo nginx -t
sudo systemctl restart nginx.service

# Install snapd and certbot
apt install snapd
apt-get remove certbot -y
snap install --classic certbot
ln -s /snap/bin/certbot /usr/bin/certbot
# certbot --nginx (fix this)