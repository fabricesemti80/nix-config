{ configVars, ... }:
{
  imports = [

    /* -------------------------------------- hardware modules -------------------------------------- */
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-cpu-intel
    # inputs.hardware.nixosModules.common-gpu-nvidia
    # inputs.hardware.nixosModules.common-gpu-intel
    # inputs.hardware.nixosModules.common-pc-ssd

     /* -------------------------------------- required configs -------------------------------------- */
    common/core

    /* ------------------------------- host-specific optional configs ------------------------------- */
    common/optional/sops.nix
    common/optional/helper-scripts
    # common/optional/desktops #FIXME: used for Hyper - no use on VM

  ];

  # services.yubikey-touch-detector.enable = true; #FIXME: sort out yubikey-stuff first

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };

  # Disable impermanence
  #home.persistence = lib.mkForce { };  
}
