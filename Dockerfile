FROM xtremxpert/docker-base:debian

MAINTAINER Xtremxpert <xtremxpert@xtremxpert.com>

ENV MAX_UPLOAD "50M"

RUN apt-get update && \
	apt-get install -y \
		apache2 \
		libapache2-mod-php5 \
		php5-mysqlnd \
		php5-curl \
		php5-gd \
		php5-intl \
		php5-imagick \
		php5-imap \
		php5-mcrypt \
		php5-memcache \
		php5-pspell \
		php5-recode \
		php5-snmp \
		php5-sqlite \
		php5-tidy \
		php5-xmlrpc \
		php5-xsl \
		php-pear \
	&& \
	rm -r /var/lib/apt/lists/*

RUN sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
	sed -i 's#^DocumentRoot ".*#DocumentRoot "/var/www/htdocs"#g' /etc/apache2/httpd.conf && \
	sed -i 's#output_buffering = 4096#output_buffering = Off#' /etc/php/php.ini && \
	sed -i \
		-e "s/^upload_max_filesize\s*=\s*2M/upload_max_filesize = $MAX_UPLOAD/" \
		-e "s/^post_max_size\s*=\s*8M/post_max_size = $MAX_UPLOAD/" \
		/etc/php/php.ini

ADD files/test.php /var/www/htdocs/

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/sbin/httpd"]
CMD ["-DFOREGROUND"]

#CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
#ENTRYPOINT [ "httpd -D FOREGROUND" ]
