{ configVars, ... }:
{
  imports = [
    #################### Required Configs ####################
    common/core #required

    #################### Host-specific Optional Configs ####################
    common/optional/sops.nix
    common/optional/helper-scripts

    # common/optional/desktops #FIXME: used for Hyper - no use on VM
  ];

  # services.yubikey-touch-detector.enable = true; #FIXME: sort out yubikey-stuff first

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
}
