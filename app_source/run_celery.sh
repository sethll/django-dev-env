#!/bin/bash

check_perms() {
    if [[ $EUID -eq 0 ]]; then
       echo "This script must be run as an unprivileged user." 
       exit 1
    fi
}

main() {
    check_perms

    # wait for RabbitMQ server to start
    sleep 10

    # run Celery worker for our project myproject with Celery configuration stored in Celeryconf
    celery worker -A app_source.celery -Q default -n default@%h
}

export RABBITMQ_PASSWORD=$(cat /run/secrets/rabbitmq_password)

main