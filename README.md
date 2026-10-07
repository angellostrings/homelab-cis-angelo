# homelab-cis-angelo
My first homelab - Ubuntu 22.04 VM (angelo) hardened to CIS Level 1.

**VM:** angelo | **Date:** Oct 2026 | **EDO, NG**

### What I did today
1. **CIS 1.1.1 Filesystem** - Disabled unused filesystems
   - Added `install cramfs /bin/false` etc to /etc/modprobe.d/cis.conf
   - Verified with `lsmod | grep cramfs` -> Not loaded PASS

2. **CIS 3.5 Firewall** - Fixed UFW inactive
   - `sudo ufw allow 22/tcp`
   - `sudo ufw --force enable`
   - `sudo ufw status` -> active

3. **CIS 5.2 SSH** - Secured SSH
   - `PermitRootLogin no`
   - `PasswordAuthentication no`
   - Fixed bug `mkdir -p /run/sshd`

Proof: /tmp/cis-angelo.sh all PASS
