FROM ubuntu:12.04
MAINTAINER Joe Beda <joe.github@bedafamily.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-dev python-pip && \
    pip install redis flask

ADD app /app

EXPOSE 80

CMD [ "python", "/app/app.py" ]


