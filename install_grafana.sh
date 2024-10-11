#!/bin/bash

set -e
CONFIGURATION_FILES=("/etc/grafana/grafana.ini" "/usr/share/grafana/conf/defaults.ini" "/usr/share/grafana/conf/sample.ini")
NEW_HTTP_PORT=$1
DEFAULT_HTTP_PORT=3000
# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

apt-get install -y apt-transport-https software-properties-common wget
mkdir -p /etc/apt/keyrings/
wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list
apt-get update && apt-get install grafana -y
echo "Successfully installed grafana, proceeding to modifying default port to: $NEW_HTTP_PORT"

for file in "${CONFIGURATION_FILES[@]}"; do
    sed -i s/"$DEFAULT_HTTP_PORT"/"$NEW_HTTP_PORT"/g "$file"
    echo "Successfully updated port: $NEW_HTTP_PORT in $file"
done

systemctl enable grafana-server && systemctl start grafana-server && systemctl status grafana-server