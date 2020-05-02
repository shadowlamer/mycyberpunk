FROM node:14.0.0-stretch-slim

ENV DIR="/project"

RUN apt-get update
RUN apt-get install -y m4 zmakebas curl qrencode

RUN mkdir $DIR
ADD src    $DIR/src
ADD tools  $DIR/tools
ADD assets $DIR/assets
ADD docker $DIR/docker
ADD package.json $DIR/package.json
ADD webpack.config.js $DIR/webpack.config.js
RUN chmod 755 $DIR/tools/*.sh
WORKDIR $DIR

RUN npm install

ADD entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
