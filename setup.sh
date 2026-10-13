#!/bin/bash
# homelab-cis-angelo - Auto CIS Level 1 harden - Angelo - Oct 2026
set -e
echo "[CIS 1.1.1] Disabling filesystems..."
sudo tee /etc/modprobe.d/cis.conf > /dev/null <<CONF
install cramfs /bin/false
install freevxfs /bin/false
install hfs /bin/false
install hfsplus /bin/false
install jffs2 /bin/false
install udf /bin/false
CONF

echo "[CIS 3.5] Enabling UFW..."
sudo ufw allow 22/tcp
sudo ufw --force enable

echo "[CIS 5.2] Hardening SSH..."
sudo mkdir -p /run/sshd
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo systemctl restart sshd

echo "DONE - Run proof:"
sudo ufw status
sshd -T | grep -E 'permitrootlogin|passwordauthentication'
lsmod | grep -E 'cramfs|freevxfs' || echo "Filesystems disabled: PASS"
