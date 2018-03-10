# django-dev-env

Docker environment for Django app development with Nginx, Gunicorn, Celery, RabbitMQ, PostgreSQL

---

**Warning:** This repo is meant as a starting point for development. *DO NOT* assume that its defaults are safe for production. Defaults are provided as a courtesy, so the user has a running state out-of-the-box. Check and re-check. 

## Features

* Replicates most major components of a Django app stack
* Containers are network-segregated:
    - `frontend` network: Nginx -> Gunicorn/Django
    - `backend-db` network: Gunicorn/Django -> PostgreSQL
    - `backend-mq` network: Gunicorn/Django -> RabbitMQ <- Celery
* Sensitive data are stored in Docker secrets
* Set up with working defaults that are defined once; see:
    - `secrets/`
    - `env-db`
    - `env-shared`
* Project can be converted to run in production or without Docker with relative ease

### Todo

* Ensure PostgreSQL db is set up and ready to use so user doesn't have to

## Requires

* [Docker](https://www.docker.com/community-edition)

## Usage

First steps:

* Place TLS certificate in `secrets/nginx_certificate.pem`
* Place TLS key in `secrets/nginx_key.pem`
* Modify PostgreSQL password in `secrets/postgres_password.txt`
* Modify RabbitMQ password in `secrets/rabbitmq_password.txt`
* Modify settings in `env-db` and `env-shared` as appropriate/desired
    - `SECRET_KEY` in `env-shared` (Generate a random string of desired length)
* Modify `docks/nginx/conf.d/web.conf` as appropriate/desired

### Running the container stack

While containers are up, access via your browser at https://127.0.0.1. 

``` bash
# git clone https://github.com/sethll/docker-nginx-django-postgresql.git dndp
# cd dndp 
docker-compose build 
docker-compose up -d
# or, to view status messages and keep an eye on behavior, just run:
# docker-compose up
#
# When finished, quit with CTRL-C, then issue
docker-compose down
```

### Proceeding with development

The user may `cd` into `app_source/`, run `python manage.py startapp my_app`, and get started right away. 

If doing local development, the user should use a [virtual environment](http://docs.python-guide.org/en/latest/dev/virtualenvs/#lower-level-virtualenv).

## Sources

Thanks to all of the Internet resources that helped me keep moving when I got stuck. Some of these were less helpful or less correct than others, but all of them helped point me to solutions.

* https://askubuntu.com/questions/15853/how-can-a-script-check-if-its-being-run-as-root/15856#15856
* https://bjornjohansen.no/redirect-to-https-with-nginx
* https://blog.docker.com/2017/07/securing-atsea-app-docker-secrets/
* https://docs.docker.com/compose/environment-variables/
* https://docs.docker.com/compose/networking/#specify-custom-networks
* https://docs.docker.com/engine/swarm/secrets/
* https://github.com/docker-library/postgres/issues/111
* https://github.com/docker-library/rabbitmq/issues/141
* https://github.com/gogobook/dockerizing-django/blob/master/docker-compose.yml
* https://github.com/pahaz/docker-compose-django-postgresql-redis-example/blob/master/sources/_project_/settings.py
* https://github.com/realpython/dockerizing-django
* https://hub.docker.com/_/postgres/
* https://hub.docker.com/_/rabbitmq/
* https://realpython.com/blog/python/django-development-with-docker-compose-and-machine/
* https://simpleisbetterthancomplex.com/tutorial/2016/05/11/how-to-setup-ssl-certificate-on-nginx-for-django-application.html
* https://simpleisbetterthancomplex.com/tutorial/2017/08/20/how-to-use-celery-with-django.html
* https://stackoverflow.com/questions/40582423/invalid-http-host-header
