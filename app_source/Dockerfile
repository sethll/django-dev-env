FROM python:3.6.4-slim-stretch

ADD . /app_source
WORKDIR /app_source

RUN apt-get update \
    && apt-get upgrade -y
#RUN postgres/setup_postgres.sh

RUN pip install -r requirements.txt
RUN adduser --uid 1000 --disabled-password --gecos '' unpriv \
    && chown -R unpriv:unpriv /app_source \
    && mkdir /static \
    && chown -R unpriv:unpriv /static

EXPOSE 8000

USER unpriv

CMD ["bash"]