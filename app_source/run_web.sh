#!/bin/bash

check_perms() {
    if [[ $EUID -eq 0 ]]; then
       echo "This script must be run as an unprivileged user." 
       exit 1
    fi
}

main() {
    check_perms
    # prepare initial migration
    python manage.py makemigrations # my_app
    # migrate
    python manage.py migrate
    # run gunicorn
    /usr/local/bin/gunicorn app_source.wsgi:application -w 2 -b :8000
}

export RABBITMQ_PASSWORD=$(cat /run/secrets/rabbitmq_password)
export DB_PASS=$(cat /run/secrets/postgres_password)

main