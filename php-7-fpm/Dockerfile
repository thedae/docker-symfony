FROM debian:jessie

RUN \
  apt-get update && \
  apt-get install -y \
  sudo \
  curl \
  wget \
  git \
  make \
  autoconf \
  imagemagick \
  nodejs \
  nodejs-legacy \
  npm

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    echo "deb-src http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.org.list && \
    wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN \
  apt-get update && \
  apt-get install -y \
  vim \
  locales \
  iptables \
  php7.0-fpm \
  php7.0-mysql \
  php7.0-gd \
  php7.0-dbg \
  php7.0-dev \
  php7.0-curl \
  php7.0-opcache \
  php7.0-cli \
  php7.0-sqlite \
  php7.0-intl \
  php7.0-tidy \
  php7.0-imap \
  php7.0-json \
  php7.0-phpdbg \
  php7.0-pspell \
  php7.0-recode \
  php7.0-common \
  php7.0-sybase \
  php7.0-sqlite3 \
  php7.0-bz2 \
  php7.0-mcrypt \
  php7.0-common \
  php7.0-xsl \
  libmemcached-dev \
  libmemcached11 \
  pkg-config

RUN \
  git clone https://github.com/krakjoe/apcu.git && \
  cd apcu && \
  phpize && \
  ./configure --with-php-config=/usr/bin/php-config && \
  make && \
  make install

RUN \
  git clone https://github.com/php-memcached-dev/php-memcached && \
  cd php-memcached && \
  git checkout -b php7 origin/php7 && \
  phpize && \
  ./configure --with-php-config=/usr/bin/php-config && \
  make && \
  make install

RUN \
  git clone https://github.com/phpredis/phpredis.git && \
  cd phpredis && \
  git checkout -b php7 origin/php7 && \
  phpize && \
  ./configure --with-php-config=/usr/bin/php-config && \
  make && \
  make install

RUN \
  echo "extension=memcached.so" >> /etc/php/mods-available/memcached.ini && \
  echo "extension=apcu.so" >> /etc/php/mods-available/apcu.ini && \
  echo "extension=redis.so" >> /etc/php/mods-available/redis.ini && \
  ln -sf /etc/php/mods-available/memcached.ini /etc/php/7.0/fpm/conf.d/20-memcached.ini && \
  ln -sf /etc/php/mods-available/apcu.ini /etc/php/7.0/fpm/conf.d/20-apcu.ini && \
  ln -sf /etc/php/mods-available/redis.ini /etc/php/7.0/fpm/conf.d/20-redis.ini && \
  ln -sf /etc/php/mods-available/memcached.ini /etc/php/7.0/cli/conf.d/20-memcached.ini && \
  ln -sf /etc/php/mods-available/apcu.ini /etc/php/7.0/cli/conf.d/20-apcu.ini && \
  ln -sf /etc/php/mods-available/redis.ini /etc/php/7.0/cli/conf.d/20-redis.ini

RUN npm install node-sass -g
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    composer global require hirak/prestissimo

RUN echo Europe/Madrid > /etc/timezone && dpkg-reconfigure --frontend noninteractive tzdata

RUN echo 'de_DE ISO-8859-1\n\
es_ES.ISO-8859-1\n\
de_DE.UTF-8 UTF-8\n\
de_DE@euro ISO-8859-15\n\
en_GB ISO-8859-1\n\
en_GB.ISO-8859-15 ISO-8859-15\n\
en_US ISO-8859-1\n\
en_US.ISO-8859-15 ISO-8859-15\n\
en_US.UTF-8 UTF-8\n\
fr_FR ISO-8859-1\n\
fr_FR.UTF-8 UTF-8\n\
fr_FR@euro ISO-8859-15\n\
nl_BE ISO-8859-1\n\
nl_BE.UTF-8 UTF-8\n\
nl_BE@euro ISO-8859-15\n\
nl_NL ISO-8859-1\n\
nl_NL.UTF-8 UTF-8\n\
nl_NL@euro ISO-8859-15\n'\
>> /etc/locale.gen &&  \
usr/sbin/locale-gen

RUN mkdir "/run/php"

ADD symfony.ini /etc/php/7.0/fpm/conf.d/
ADD symfony.ini /etc/php/7.0/cli/conf.d/
ADD symfony.pool.conf /etc/php/7.0/fpm/pool.d/

RUN usermod -u 1000 www-data

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.0", "--allow-to-run-as-root", "-c", "/etc/php/7.0/fpm", "--nodaemonize"]