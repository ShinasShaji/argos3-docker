#!/usr/bin/env bash

# Wait for X server to start (adjust sleep time if needed)
sleep 10

# Allow VNC connections to the X server
xhost +local:root 