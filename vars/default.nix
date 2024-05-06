{ inputs, lib }:
{


  username = "fs";
  domain = inputs.nix-secrets.domain;
  userFullName = inputs.nix-secrets.full-name;
  gitHandle = "fabricesemti80";
  glHandle = "fabricesemti";
  gitEmail = "fabrice@fabricesemti.com"; #"37410363 + fabricesemti80@users.noreply.github.com";
  workEmail = inputs.nix-secrets.work-email;
  networking = import ./networking.nix { inherit lib; };
}
