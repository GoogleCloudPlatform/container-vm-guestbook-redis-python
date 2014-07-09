FROM micktwomey/python3.4:latest
MAINTAINER Joe Beda <joe.github@bedafamily.com>

RUN pip3 install dc-campaign-finance-data


CMD [ "dc-campaign-finance-data", "committees" ]


