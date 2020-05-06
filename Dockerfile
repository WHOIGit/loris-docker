FROM python:3.7.3 AS base

COPY ./loris /loris
WORKDIR /loris

RUN pip install -r requirements.txt \
    && python setup.py install


FROM nginx:1.18

RUN apt update \
    && apt install -y python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Note: Nginx's container is based on Debian, which uses dist-packages/ instead
# of site-packages/.
COPY --from=base \
     /usr/local/lib/python3.7/site-packages \
     /usr/local/lib/python3.7/dist-packages

RUN pip3 install uwsgi

RUN mkdir /var/cache/loris \
    && chown nginx:nginx /var/cache/loris

COPY ./loris/www /var/www/loris2

COPY ./loris2.conf /etc/
COPY ./start.sh ./wsgi/loris.wsgi ./wsgi/uwsgi.ini /opt/loris/
COPY /nginx/default.conf /etc/nginx/conf.d/

CMD /opt/loris/start.sh
