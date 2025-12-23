#!/bin/bash

LOKI_VERSION="2.9.2"

echo "[*] Membuat direktori untuk Loki..."
sudo mkdir -p /opt/loki
sudo mkdir -p /var/lib/loki

echo "[*] Mendownload Loki..."
cd /tmp
wget https://github.com/grafana/loki/releases/download/v${LOKI_VERSION}/loki-linux-amd64.zip
unzip loki-linux-amd64.zip
sudo mv loki-linux-amd64 /usr/local/bin/loki
sudo chmod +x /usr/local/bin/loki

echo "[*] Membuat konfigurasi Loki..."
sudo tee /opt/loki/loki-config.yaml > /dev/null <<EOF
auth_enabled: false

server:
  http_listen_port: 3100
  grpc_listen_port: 9096

common:
  path_prefix: /var/lib/loki
  storage:
    filesystem:
      chunks_directory: /var/lib/loki/chunks
      rules_directory: /var/lib/loki/rules
  replication_factor: 1
  ring:
    instance_addr: 127.0.0.1
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2020-10-24
      store: boltdb-shipper
      object_store: filesystem
      schema: v11
      index:
        prefix: index_
        period: 24h
EOF

echo "[*] Membuat systemd service..."
sudo tee /etc/systemd/system/loki.service > /dev/null <<EOF
[Unit]
Description=Loki Log Aggregation System
After=network.target

[Service]
ExecStart=/usr/local/bin/loki -config.file=/opt/loki/loki-config.yaml
Restart=always

[Install]
WantedBy=multi-user.target
EOF

echo "[*] Mengaktifkan Loki..."
sudo systemctl daemon-reload
sudo systemctl enable loki
sudo systemctl start loki

echo "[✓] Loki berhasil diinstall!"
echo ""
echo "Loki berjalan di: http://localhost:3100"
echo "Gunakan dengan Grafana untuk visualisasi log"
