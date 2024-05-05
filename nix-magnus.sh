#!/bin/sh

#TODO: replace this with just/make/tasks!

# Get target host
export TARGET_HOST=magnus

# Check if the current host matches the TARGET_HOST
if [ ${HOSTNAME}  = ${TARGET_HOST} ]; then
  # Perform local build
  # Apply flake
  sudo nixos-rebuild switch --flake .#${HOSTNAME} \
  # Apply Home manager
  home-manager switch --flake .#${USER}@${HOSTNAME} 
else
  # Perform remote build
  sudo nixos-rebuild switch --flake .#${TARGET_HOST} \
    --target-host root@${TARGET_HOST} --build-host root@${TARGET_HOST} --verbose
fi
