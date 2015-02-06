FROM ubuntu:latest

RUN update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:chris-lea/node.js
RUN apt-get update

RUN apt-get install -y curl git nodejs
RUN curl https://install.meteor.com/ | sh

ADD . /app

WORKDIR /app

EXPOSE 80

CMD ["meteor" "--port" "80"]
