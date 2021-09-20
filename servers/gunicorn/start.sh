#!/bin/sh

if [ -z "${WORKERS}" ]; then
    WORKERS=
fi

/usr/local/bin/gunicorn -k uvicorn.workers.UvicornWorker -w ${WORKERS} --log-level error --bind 0.0.0.0:8080 app:app
