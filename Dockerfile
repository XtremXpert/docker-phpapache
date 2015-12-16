FROM xtremxpert/docker-alpine:latest

MAINTAINER Xtremxpert <xtremxpert@xtremxpert.com>

RUN apk -U upgrade && \
	apk --update add \
		php-apache2 \
		php-cli \
		php-ctype \
		php-curl \
		php-exif \
		php-gd \
		php-json \
		php-mysqli \
		php-opcache \
		php-openssl \
		php-phar \
		php-xml \
		php-zip \
		php-zlib \
	&& \
	sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
	sed -i 's#output_buffering = 4096#output_buffering = Off#' /etc/php/php.ini && \
	sed -i \
		-e "s/^upload_max_filesize\s*=\s*2M/upload_max_filesize = 64M/" \
		-e "s/^post_max_size\s*=\s*8M/post_max_size = 64M/" \
		/etc/php/php.ini \
	&& \
	chmod u+x /*.sh && \
	rm -rf /var/cache/apk/*

EXPOSE 80

ENTRYPOINT [ "httpd -D FOREGROUND" ]
