FROM alpine:3.6

MAINTAINER Matheus Garcia <garcia.figueiredo@gmail.com>
MAINTAINER Fabio Rauber <fabiorauber@gmail.com>

ENV ESCOLA_MODELO_GITHUB=https://github.com/interlegis/moodle.git \
    ESCOLA_MODELO_DATA=/var/escolamodelodata \
    ESCOLA_MODELO_REVERSEPROXY=false \
    ESCOLA_MODELO_SSLPROXY=true \
    ESCOLA_MODELO_VERSION=3.7.0-2

EXPOSE 80

VOLUME ["/var/escolamodelodata"]

RUN apk update \
 && apk add --no-cache \
                       dcron \
                       vim \
		       git \
                       apache2 \
                       php7 \
                       php7-apache2 \
                       php7-iconv \
                       php7-pgsql \
                       php7-session \
                       php7-json \
                       php7-xml \
                       php7-curl \
                       php7-zip \
                       php7-zlib \
                       php7-gd \
                       php7-dom \
                       php7-xmlreader \
                       php7-mbstring \
                       php7-openssl \
                       php7-xmlrpc \
                       php7-soap \
                       php7-intl \
                       php7-opcache \
                       php7-tokenizer \
                       php7-simplexml \
                       php7-ctype \
                       php7-fileinfo \
		       php7-phar

RUN cd /tmp \
 && git clone ${ESCOLA_MODELO_GITHUB} --depth=1 --branch EM_${ESCOLA_MODELO_VERSION} \
 && rm -rf /var/www/localhost/htdocs \
 && cd moodle \
 && git submodule init \
 && git submodule update \ 
 && cd .. \
 && mv /tmp/moodle /var/www/localhost/htdocs \
 && chown apache:apache -R /var/www/localhost/htdocs \
 && mkdir /run/apache2

RUN ln -sf /proc/self/fd/1 /var/log/apache2/access.log \
 && ln -sf /proc/self/fd/1 /var/log/apache2/error.log

COPY 00_limits.ini /etc/php7/conf.d/00_limits.ini
COPY 00_opcache.ini /etc/php7/conf.d/00_opcache.ini
COPY install.sh /usr/local/bin
COPY run.sh /opt/apache2/run.sh

COPY crontab /etc/crontabs/root
COPY startcron.sh /usr/local/bin

COPY moodle-config.php /var/www/localhost/htdocs/

CMD ["/opt/apache2/run.sh"]
