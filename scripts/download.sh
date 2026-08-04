#bin/bash

set -e echo "Start download system"
echo "Host: $SFTIP_HOST"
echo "Path: $SFTP_PATH"

mdkir -p/data

sshpass -p "$SFTP_PASSWORD" \
  sftp \
  -o StrictHostKeyChecking=no \
  "$SFTP_USERNAME@$SFTP_HOST" <<EOF
cd $SFTP_PATH
lcd /data
mget *.xlsx
bye
EOF

echo "Download completed."
