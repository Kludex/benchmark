#!/bin/sh

if [ -z "${WORKERS}" ]; then
    WORKERS=1
fi

/usr/local/bin/hypercorn --log-level error -w ${WORKERS} -k uvloop --bind 0.0.0.0:8080 app:app
