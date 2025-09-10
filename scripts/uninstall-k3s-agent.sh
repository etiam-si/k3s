#!/bin/bash
set -e

echo "Stopping and disabling k3s agent service..."
systemctl stop k3s-agent || true
systemctl disable k3s-agent || true

echo "Running official k3s-agent-uninstall.sh..."
if [ -f /usr/local/bin/k3s-agent-uninstall.sh ]; then
    /usr/local/bin/k3s-agent-uninstall.sh
else
    echo "⚠️  k3s-agent-uninstall.sh not found, cleaning manually..."
    systemctl stop k3s-agent || true
    systemctl disable k3s-agent || true
    rm -f /etc/systemd/system/k3s-agent.service
    rm -f /etc/systemd/system/k3s-agent.service.env
    rm -rf /etc/rancher/k3s
    rm -rf /var/lib/rancher/k3s
    rm -f /usr/local/bin/k3s
    systemctl daemon-reload
    systemctl reset-failed
fi

echo "✅ K3s agent uninstalled successfully."
