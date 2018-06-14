#!/bin/sh

# Se não existe escolamodelodata, então é instalação inicial
if [ ! -d /var/escolamodelodata ]; then
  mkdir /var/escolamodelodata
fi

if [ ! -f /var/escolamodelodata/dummy ]; then 
  chown -R apache:apache /var/escolamodelodata
  echo "placeholder" > /var/escolamodelodata/dummy
  # instala o moodle, criando objetos no BD e gerando arquivo config.php
  /usr/local/bin/install.sh
  # sobrescreve config.php gerado, uma vez que faltam configurações de proxy, dentre outras
  cp /var/www/localhost/htdocs/moodle-config.php /var/www/localhost/htdocs/config.php
fi

# Atribui proprietário do moodledata e config.php
chown apache:apache /var/www/localhost/htdocs/config.php
chown apache:apache /var/escolamodelodata -R

# Inicializa o servidor web
exec /usr/sbin/httpd -D FOREGROUND
