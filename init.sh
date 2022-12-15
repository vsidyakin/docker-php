#!/bin/bash

# Configure ssmtp
dockerize -template "${TEMPLATES_DIR}/ssmtp.conf.tmpl" > "/etc/ssmtp/ssmtp.conf"
# Configure PHP
dockerize -template "${TEMPLATES_DIR}/php.ini.tmpl"  > "/etc/php/${PHP_VERSION}/fpm/php.ini"
dockerize -template "${TEMPLATES_DIR}/www.conf.tmpl" > "/etc/php/${PHP_VERSION}/fpm/pool.d/www.conf"

# if there's something to setup before running PHP-FPM, do it now - run scripts from /prerun
if [ -f /prerun/*.sh ]; then
	for PRERUN in /prerun/*.sh; do
		${PRERUN}
	done
fi

exec "$@"

