{ configVars, ... }:
{
  imports = [
    #################### Required Configs ####################
    common/core #required

    #################### Host-specific Optional Configs ####################
    common/optional/sops.nix
    common/optional/helper-scripts

    common/optional/desktops #FIXME: enable desktops latter - now we just want minimal to work
  ];

  # services.yubikey-touch-detector.enable = true; #FIXME: sort out yubikey-stuff first

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
