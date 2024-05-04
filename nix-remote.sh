#!/bin/sh

#TODO: replace this with just/make/tasks!

export TARGET_HOST=magnus

# Update repo
git pull \
# Remote deployment
nixos-rebuild switch --flake .#${TARGET_HOST} \
  --target-host root@${TARGET_HOST} --build-host root@${TARGET_HOST}--verbose