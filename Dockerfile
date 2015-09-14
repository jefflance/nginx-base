# nginx-base
#   Debian base install with Nginx.
#   Based on official Dockerfile from Nginx but i use here my own
#   customized debian image.
#

FROM jefflance/debian-base:latest
MAINTAINER Jeff LANCE <jeff.lance@mala.fr>


ENV NGINX_VERSION="1.9.4-1~jessie"


RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62
RUN echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y ca-certificates nginx=${NGINX_VERSION} && \
    apt-get clean

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# configure system
COPY configure.sh /tmp/configure.sh
RUN /bin/bash /tmp/configure.sh && rm /tmp/configure.sh


VOLUME ["/srv"]
EXPOSE 80 443

# there's no ENTRYPOINT command as its provides by the FROM image.
# start configured services
CMD ["/usr/sbin/runsvdir-start"]
