#!/usr/bin/env bash
# set -euxo pipefail # if uncommented, will exit on any error including apt-get update

# 0. install SSH, sudo, and GPG tools
apt-get update
apt-get install -y openssh-server sudo gnupg dirmngr
mkdir -p /var/run/sshd

# 1. import Google Chrome public key so apt-get update succeeds (not needed for Argos)
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 32EE5355A6BC6E42

# 2. create dev user (uid 1000) and set its password
useradd -m -u 1000 -s /bin/bash dev
: "${DEV_PASSWORD:=dev}"
echo "dev:${DEV_PASSWORD}" | chpasswd

# 3. give dev passwordless sudo
echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# 4. enable password authentication
sed -ri 's/^#?PasswordAuthentication\s+.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
grep -qxF 'UseDNS no' /etc/ssh/sshd_config || echo 'UseDNS no' >> /etc/ssh/sshd_config