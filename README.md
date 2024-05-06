# My personal Nix development

This flake is mostly based on  [misterio's Nix starter](https://github.com/Misterio77/nix-starter-configs) but it also heavily relies on [EmergentMind's Nix config](https://github.com/EmergentMind/nix-config).

## My main goals are:
- having an easily reproducable dev server in my homelab --> currently this is run as NixOS VM on my Proxmox cluster
- having an easily reproducable dev laptop as my daily driver --> (still deciding if this will be NixOS or something else)
- having an easily reproducable dev server in work --> due to constraints this should be Debian 12+ and running on VMWare
- having a host of k8s servers with an easily reproducable config --> these will run on Proxmox

## Side-goals

- Having to nix-ify other systems I control
