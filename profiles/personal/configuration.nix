# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ userSettings, ... }:
{
  imports =
    [ ../work/configuration.nix # Personal is essentially work system + games
      ../../system/hardware-configuration.nix

      # FIXME: allow games when on hardware
      # ../../system/app/gamemode.nix
      # ../../system/app/steam.nix
      ../../system/app/prismlauncher.nix
      ../../system/security/doas.nix
      ../../system/security/gpg.nix
      ../../system/security/blocklist.nix
      ../../system/security/firewall.nix
      
      #FIXME:  allow SSH for now; remove when moved to physical hw from VM
      ( import ../../system/security/sshd.nix {
                authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJpVWYmXPpqVmlHdixDR//vdfD+sryvYmpH2Dj1/Otx fabrice@fabricesemti.com"];
      inherit userSettings; })
    ];
}
