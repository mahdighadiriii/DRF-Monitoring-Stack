FROM python:3.10-slim-buster

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

RUN apt-get update \
    && apt-get -y install build-essential libpq-dev netcat \
    && apt-get clean

COPY requirements.txt /app/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

RUN mkdir -p /app/.sh

COPY .sh/dev.sh /app/.sh/dev.sh
COPY ./core /app/
COPY ./postgres/scripts/db_script.sh /docker-entrypoint-initdb.d/db_script.sh

RUN chmod +x /app/.sh/dev.sh \
    && chmod +x /docker-entrypoint-initdb.d/db_script.sh
