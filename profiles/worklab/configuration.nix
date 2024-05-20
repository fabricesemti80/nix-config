{ userSettings, ... }:

{
  imports = [ ../homelab/base.nix
              ( import ../../system/security/sshd.nix {
                authorizedKeys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBJpVWYmXPpqVmlHdixDR//vdfD+sryvYmpH2Dj1/Otx fabrice@fabricesemti.com" ];
                inherit userSettings; })
            ];
}
