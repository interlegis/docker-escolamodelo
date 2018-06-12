#!/bin/sh

# Se não existe escolamodelodata, então é instalação inicial
# Cria o diretório e executa procedimento de instalação
if [ ! -d /var/escolamodelodata ]; then
  mkdir /var/escolamodelodata
  /usr/local/bin/install.sh
fi

if [ ! -f /var/moodledata/placeholder ]; then 
  chown -R apache:apache /var/escolamodelodata
  echo "placeholder" > /var/escolamodelodata/placeholder
fi
chown apache:apache /var/escolamodelodata
exec /usr/sbin/httpd -D FOREGROUND
