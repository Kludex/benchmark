#!/bin/sh

if [ -z "${WORKERS}" ]; then
    WORKERS=1
fi

/usr/local/bin/uvicorn --log-level error --no-access-log --host 0.0.0.0 --workers ${WORKERS} --port 8080 app:app
