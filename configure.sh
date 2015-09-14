#!/bin/bash

runit_nginx() {
	mkdir /etc/service/nginx
    echo -e "#!/bin/sh" > /etc/service/nginx/run
    echo -e 'exec 2>&1' >> /etc/service/nginx/run
    echo -e 'exec /usr/sbin/nginx -g "daemon off;"' >> /etc/service/nginx/run

    chown root.root /etc/service/nginx/run
    chmod 755 /etc/service/nginx/run
}


runit_nginx


exit 0
