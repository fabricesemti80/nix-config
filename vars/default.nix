{ inputs, lib }:
{
  

  username = "fs";
  domain = inputs.nix-secrets.domain;
  userFullName = inputs.nix-secrets.full-name; 
  handle = "fabricesemti";
  gitEmail = "1234+fabricesemti80@users.noreply.github.com";
  workEmail = inputs.nix-secrets.work-email; 
  networking = import ./networking.nix { inherit lib; };
}
