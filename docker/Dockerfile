FROM nginx:alpine

ARG site_url="localhost"
ARG maintainer_name="maintainer"
ARG maintainer_email="$maintainer_name@$site_url"

ENV HTMLDIR="/var/www/html"
ENV CERTDIR="/sslcerts"
ENV MNT_EMAIL="$maintainer_email"
ENV SITE_URL=$site_url

RUN apk update
RUN apk add openssl

ADD prepareweb.sh prepareweb.sh
RUN chmod 755 prepareweb.sh
RUN ./prepareweb.sh

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 entrypoint.sh

COPY build/ ${HTMLDIR}

EXPOSE 80 443

ENTRYPOINT ["./entrypoint.sh"]

