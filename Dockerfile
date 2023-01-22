FROM debian:11.6-slim

ARG DEBIAN_FRONTEND=noninteractive

WORKDIR /app

RUN set -eux; \
    apt-get update; \
    apt-get -y dist-upgrade; \
    apt-get install -y --no-install-recommends python-is-python3 python3-pip; \
    apt-get clean all; \
    rm -r /var/lib/apt/lists /var/cache/apt/archives

COPY app.py /app/app.py
COPY requirements.txt /app/requirements.txt

RUN pip3 install -r /app/requirements.txt

EXPOSE 8080

CMD ["gunicorn", "-b", "0.0.0.0:80", "-w", "4", "app:app", "--access-logfile", "-"]
