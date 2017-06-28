FROM debian:8
# INSTALL SOGO
RUN apt-key adv --keyserver keys.gnupg.net --recv-key 0x810273C4 && \
    apt-get update && \
    apt-get install nginx -y && \
    echo "deb http://packages.inverse.ca/SOGo/nightly/3/debian/ jessie jessie" >> /etc/apt/sources.list && \
    apt-get update && \
    apt-get install sogo sope4.9-gdl1-postgresql -y
# Install CONFD
ADD https://github.com/kelseyhightower/confd/releases/download/v0.11.0/confd-0.11.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
# Install configure CADDY
# LOAD CONFD TEMPLATES
VOLUME ["/etc/confd", "/etc/sogo", "/etc/nginx"]
ADD files/confd /etc/confd
ADD run.sh ./run.sh
ENTRYPOINT "./run.sh"
