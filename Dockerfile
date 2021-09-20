FROM python:3.9-slim as base

# hadolint ignore=DL3008
RUN apt-get update \
    && apt-get -y install --no-install-recommends build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

FROM base as build

ARG SERVER
ARG APP

COPY servers/$SERVER/* /app/
RUN /usr/local/bin/pip install --no-cache-dir -r /app/requirements.txt && rm /app/requirements.txt

COPY apps/$APP/* /app/
RUN /usr/local/bin/pip install --no-cache-dir -r /app/requirements.txt && rm /app/requirements.txt

EXPOSE 8080
WORKDIR /app

RUN chmod +x /app/start.sh
ENTRYPOINT [ "/app/start.sh" ]
