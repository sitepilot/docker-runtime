FROM ubuntu:20.04
LABEL maintainer "Sitepilot <support@sitepilot.io>"

ENV PHP_VERSION=74
ENV PATH="/opt/sitepilot/bin:${PATH}"

ENV APP_PATH=/opt/sitepilot/app
ENV APP_PATH_PUBLIC=/opt/sitepilot/app/public
ENV APP_PATH_LOGS=/opt/sitepilot/app/logs
ENV APP_PATH_AUTH=/opt/sitepilot/app/.auth
ENV COMPOSER_HOME=/opt/sitepilot/app/.composer
ENV APP_PATH_DEPLOY=/opt/sitepilot/app/deploy
ENV APP_PATH_DEPLOY_DATA=/opt/sitepilot/app/deploy/.data

# ----- Build Files ----- #

COPY build /

# ----- Packages ----- #

RUN install-packages sudo software-properties-common supervisor curl wget gpg-agent unzip mysql-client git ssh msmtp nano openssh-server restic rsync

# ----- Openlitespeed & PHP ----- #

RUN wget -O - http://rpms.litespeedtech.com/debian/enable_lst_debian_repo.sh | bash

RUN install-packages \
    lsphp$PHP_VERSION \
    lsphp$PHP_VERSION-mysql \
    lsphp$PHP_VERSION-imap \
    lsphp$PHP_VERSION-curl \
    lsphp$PHP_VERSION-common \
    lsphp$PHP_VERSION-json \
    lsphp$PHP_VERSION-redis \
    lsphp$PHP_VERSION-opcache \
    lsphp$PHP_VERSION-igbinary \
    lsphp$PHP_VERSION-imagick \
    lsphp$PHP_VERSION-intl \
    openlitespeed

RUN ln -sf /usr/local/lsws/lsphp$PHP_VERSION/bin/php /usr/local/bin/php \
    && ln -sf /opt/sitepilot/etc/litespeed/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf \
    && ln -sf /opt/sitepilot/etc/php/php.ini /usr/local/lsws/lsphp74/etc/php/7.4/mods-available/99-sitepilot.ini

# ----- Runtime ----- #

RUN wget https://github.com/sitepilot/runtime/releases/latest/download/runtime -O /opt/sitepilot/bin/runtime \
    && chmod +x /opt/sitepilot/bin/runtime \
    && runtime --version

# ----- Composer ----- #

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && mv composer.phar /usr/local/bin/composer \
    && php -r "unlink('composer-setup.php');" \
    && composer --version

# ----- NodeJS ----- #

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo bash - \
    && install-packages nodejs \
    && npm -v \
    && node -v \
    && npm install -g yarn

# ----- WPCLI ----- #

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && wp --allow-root --version

# ----- Wordmove ----- #

#RUN install-packages ruby \
#    && gem install --no-user-install wordmove \
#    && wordmove --version

# ----- Webhook ----- #

RUN install-packages webhook

# ------ User ----- #

RUN echo "www-data ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
    && usermod -u 10000 -d /opt/sitepilot/app www-data \
    && groupmod -g 10000 www-data \
    && chsh -s /bin/bash www-data
    
# ----- Files ----- #

COPY filesystem /

RUN mkdir -p /var/run \
    && mkdir -p /opt/sitepilot/etc \
    && chown -R www-data:www-data /run \
    && chown -R www-data:www-data /opt/sitepilot \
    && chown -R www-data:www-data /usr/local/lsws \
    && ln -sf /dev/stderr /usr/local/lsws/logs/error.log \
    && ln -sf /dev/stderr /usr/local/lsws/logs/stderr.log

# ----- Config ----- #

EXPOSE 8080
EXPOSE 8443

USER 10000:10000

WORKDIR /opt/sitepilot/app

ENTRYPOINT ["/opt/sitepilot/bin/entrypoint"]

CMD ["supervisord", "-c", "/opt/sitepilot/etc/supervisor/supervisor.conf"]
