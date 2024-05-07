{ inputs, lib }:
{

  /* ---------------------------------------------------------------------------------------------- */
  /*                   THE VARIABLES DEFINED HERE ARE IMPORTED UNDER `CONFIGVARS`                   */
  /* ---------------------------------------------------------------------------------------------- */

  /* ------------------------------ User details ------------------------------ */
  username = "fs";
  userFullName = inputs.nix-secrets.full-name;
  gitHandle = "fabricesemti80";
  glHandle = "fabricesemti";
  gitEmail = "fabrice@fabricesemti.com"; #"37410363 + fabricesemti80@users.noreply.github.com";
  workEmail = inputs.nix-secrets.work-email;

  /* ------------------------------- Networking ------------------------------- */
  domain = inputs.nix-secrets.domain;
  networking = import ./networking.nix { inherit lib; };

  /* --------------------------------- Locals --------------------------------- */
  timeZone = "Europe/London";
  encoding = "en_GB.UTF-8";

}
