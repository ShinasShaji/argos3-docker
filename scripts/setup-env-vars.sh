#!/bin/bash

# First, get the default PATH
DEFAULT_PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

# Create environment file with current container environment
env | grep -v '^_' | grep -v '^HOSTNAME=' | grep -v '^HOME=' | grep -v '^PWD=' | grep -v '^TERM=' > /etc/environment
# Ensure PATH is set
grep -q '^PATH=' /etc/environment || echo "PATH=$DEFAULT_PATH" >> /etc/environment

# Create profile script to set environment variables for all shells
echo '#!/bin/bash' > /etc/profile.d/00-argos-env.sh
env | grep -v '^_' | grep -v '^HOSTNAME=' | grep -v '^HOME=' | grep -v '^PWD=' | grep -v '^TERM=' | sed 's/^/export /' >> /etc/profile.d/00-argos-env.sh
chmod +x /etc/profile.d/00-argos-env.sh

# Extract environment variable names and add them to AcceptEnv in sshd_config
ENV_VARS=$(env | grep -v '^_' | grep -v '^HOSTNAME=' | grep -v '^HOME=' | grep -v '^PWD=' | grep -v '^TERM=' | cut -d= -f1 | tr '\n' ' ')
sed -i '/^AcceptEnv/d' /etc/ssh/sshd_config  # Remove any existing AcceptEnv lines
echo "AcceptEnv $ENV_VARS" >> /etc/ssh/sshd_config

# Restart sshd to pick up the new configuration
service ssh restart 