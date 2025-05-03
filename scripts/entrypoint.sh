#!/usr/bin/env bash
set -e

# 1. Persist env vars and configure SSH
/setup/setup-env-vars.sh

# 2. Start VNC X permissions setup in background
/setup/post-vnc-setup.sh &

# 3. Launch SSH daemon
/usr/sbin/sshd

# 4. Hand off to Argos' startup
exec /startup.sh "$@"