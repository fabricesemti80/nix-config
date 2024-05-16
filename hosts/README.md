# Hosts

Host configurations

Each host has their own folder.

Each folder has two files:

- `hardware-configuration.nix` --> this should come from the host (add it on an existing host or `cp` it from `/etc/nixos/` folder before deployment)

- `default.nix` should contain the generic system configuration, ie, bootloader or networking

The `common` folder contains services that are common (but some of them are still _optional!_) to each host