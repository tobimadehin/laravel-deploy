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