#!/bin/sh

#TODO: replace this with just/make/tasks!

# Get current hostname
export TARGET_HOST=magnus
export CURRENT_HOST=$(hostname)

# Check if the current host matches the TARGET_HOST
if [ "$CURRENT_HOST" = "$TARGET_HOST" ]; then
  # Perform local build
  nixos-rebuild switch --flake .#${TARGET_HOST}
else
  # Perform remote build
  nixos-rebuild switch --flake .#${TARGET_HOST} \
    --target-host root@${TARGET_HOST} --build-host root@${TARGET_HOST} --verbose
fi
