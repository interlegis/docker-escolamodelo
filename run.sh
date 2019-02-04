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
fi

# sobrescreve config.php gerado, uma vez que faltam configurações de proxy, dentre outras
cp /var/www/localhost/htdocs/moodle-config.php /var/www/localhost/htdocs/config.php

# Executa comando de upgrade, caso haja atualizações a serem realizadas
/usr/bin/php /var/www/localhost/htdocs/admin/cli/upgrade.php --non-interactive

# Atribui proprietário do moodledata e config.php
chown apache:apache /var/www/localhost/htdocs/config.php
chown apache:apache /var/escolamodelodata -R

# Inicializa o servidor web
exec /usr/sbin/httpd -D FOREGROUND
