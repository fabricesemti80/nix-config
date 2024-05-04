#!/bin/sh

#TODO: replace this with just/make/tasks!
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'

# Update repo
# echo -e "${GREEN} Updating from source repo ..." \
git pull \
# update flake
# echo -e "${YELLOW} Updating flake ..." \
nix flake update \
# Apply flake
# echo -e "${BLUE} Applying [system] flake for ${HOSTNAME}  ..." \
sudo nixos-rebuild switch --flake .#${HOSTNAME} \
# Apply Home manager
# echo -e "${BLUE} Applying [user] home for ${USER} ..." \
home-manager switch --flake .#${USER}@${HOSTNAME}  #\
# # GC
# nix-env --delete-generations 14d && nix-store --gc