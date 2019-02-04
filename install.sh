#!/bin/sh

/usr/bin/php /var/www/localhost/htdocs/admin/cli/install.php --lang=pt_BR --wwwroot="$ESCOLA_MODELO_URL" --dataroot=/var/escolamodelodata --dbtype=pgsql --dbhost="$ESCOLA_MODELO_DB_HOST" --dbname="$ESCOLA_MODELO_DB_NAME" --dbuser="$ESCOLA_MODELO_DB_USER" --dbpass="$ESCOLA_MODELO_DB_PASS" --fullname="$ESCOLA_MODELO_CASA_LEGISLATIVA" --shortname="$ESCOLA_MODELO_NOME_CURTO" --adminuser=admin --adminpass="$ESCOLA_MODELO_ADMIN_PASS" --adminemail="suporte@interlegis.leg.br" --non-interactive --agree-license;

