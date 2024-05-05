{ inputs, lib }:
{
  

  username = "fs";
  # domain = inputs.nix-secrets.domain; #TODO: create secrets
  # userFullName = inputs.nix-secrets.full-name; #TODO: create secrets
  handle = "fabricesemti";
  # userEmail = inputs.nix-secrets.user-email; #TODO: create secrets
  # gitEmail = "7410928+emergentmind@users.noreply.github.com"; #TODO: create secrets
  # workEmail = inputs.nix-secrets.work-email; #TODO: create secrets
  networking = import ./networking.nix { inherit lib; };
}
