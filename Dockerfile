FROM google/debian:wheezy
MAINTAINER Joe Beda <joe.github@bedafamily.com>

RUN apt-get update && \
    apt-get install -y python-dev python-pip && \
    pip install redis flask

ADD app /app

EXPOSE 80

CMD [ "python", "/app/app.py" ]


