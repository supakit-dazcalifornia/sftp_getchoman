#!/bin/bash

trap 'LOG_TIME=$(date "+%Y-%m-%d %H:%M:%S"); echo "[$LOG_TIME] ERROR at line $LINENO"' ERR
set -e

if [ -f /app/.env ]; then
  set -a
  source /app/.env
  set +a
fi

LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$LOG_TIME] Start download system"
echo "[$LOG_TIME] Host: $SFTP_HOST"
echo "[$LOG_TIME] Path: $SFTP_PATH"
echo "[$LOG_TIME] Username: $SFTP_USERNAME"
echo "[$LOG_TIME] Password length: ${#SFTP_PASSWORD}"

mkdir -p /data

sshpass -p "$SFTP_PASSWORD" \
  sftp \
  -o StrictHostKeyChecking=no \
  "$SFTP_USERNAME@$SFTP_HOST" <<EOF
cd $SFTP_PATH
lcd /data
mget *.csv
mget *.xls
mget *.xlsx
bye
EOF

LOG_TIME=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$LOG_TIME] Download completed."
