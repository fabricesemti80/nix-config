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
    ./common/core #required

    /* ------------------------------- host-specific optional configs ------------------------------- */


  ];

  home = {
    username = configVars.username;
    homeDirectory = "/home/${configVars.username}";
  };
  
  # Disable impermanence
  #home.persistence = lib.mkForce { };
}
