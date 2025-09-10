#!/bin/bash
set -e

echo "Stopping and disabling k3s server service..."
systemctl stop k3s || true
systemctl disable k3s || true

echo "Running official k3s-uninstall.sh..."
if [ -f /usr/local/bin/k3s-uninstall.sh ]; then
    /usr/local/bin/k3s-uninstall.sh
else
    echo "⚠️  k3s-uninstall.sh not found, cleaning manually..."
    systemctl stop k3s || true
    systemctl disable k3s || true
    rm -f /etc/systemd/system/k3s.service
    rm -f /etc/systemd/system/k3s.service.env
    rm -rf /etc/rancher/k3s
    rm -rf /var/lib/rancher/k3s
    rm -f /usr/local/bin/k3s
    systemctl daemon-reload
    systemctl reset-failed
fi

echo "✅ K3s server uninstalled successfully."
