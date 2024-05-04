#!/bin/sh

#TODO: replace this with just/make/tasks!

# Update repo
git pull \
# update flake
nix flake update \
# Apply flake
sudo nixos-rebuild switch --flake .#${HOSTNAME} \
# Apply Home manager
home-manager switch --flake .#${USER}@${HOSTNAME}  #\
# # GC
# nix-env --delete-generations 14d && nix-store --gc