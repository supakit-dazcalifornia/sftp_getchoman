FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y \
        openssh-client \
        sshpass \
        cron \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/download.sh /scripts/download.sh
COPY crontab /etc/cron.d/sftp-download
COPY .env /app/.env

RUN chmod +x /scripts/download.sh \
    && chmod 0644 /etc/cron.d/sftp-download

CMD ["cron", "-f"]
