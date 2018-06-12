#!/bin/sh

# Se não existe escolamodelodata, então é instalação inicial
if [ ! -d /var/escolamodelodata ]; then
  mkdir /var/escolamodelodata
fi

if [ ! -f /var/moodledata/placeholder ]; then 
  chown -R apache:apache /var/escolamodelodata
  echo "placeholder" > /var/escolamodelodata/placeholder
fi
chown apache:apache /var/www/localhost/htdocs/config.php
chown apache:apache /var/escolamodelodata
exec /usr/sbin/httpd -D FOREGROUND
