{ inputs, outputs, ... }: {

  /* ---------------------------------------------------------------------------------------------- */
  /*                                 CORRE HOST CONFIG FOR ALL HOSTS                                */
  /* ---------------------------------------------------------------------------------------------- */

  /* ------------------------- - basic programs and services for all hot -------------------------- */

  imports = [
    inputs.home-manager.nixosModules.home-manager

    ./locale.nix # localization settings

    ./nix.nix # nix settings and garbage collection
    ./nixpkgs.nix # nix package settings

    # ./sops.nix # secrets management #FIXME: moved this to "secrets" folder

    ./zsh.nix # load a basic shell just in case we need it without home-manager
    ./services/auto-upgrade.nix # auto-upgrade service



  ] ++ (builtins.attrValues outputs.nixosModules);

  # services.yubikey-agent.enable = true; #FIXME: re-enable when Yubikey done

  /* -------------------------------------- security defaults ------------------------------------- */

  security.sudo.extraConfig = ''
    Defaults timestamp_timeout=120 # only ask for password every 2h
    # Keep SSH_AUTH_SOCK so that pam_ssh_agent_auth.so can do its magic.
    # Defaults env_keep + =SSH_AUTH_SOCK
  '';

  # https://nixos-and-flakes.thiscute.world/best-practices/remote-deployment#remote-deployment
  security.sudo.wheelNeedsPassword = false;

  home-manager.extraSpecialArgs = { inherit inputs outputs; };



  /* -------------------------------------- hardware defaults ------------------------------------- */

  hardware.enableRedistributableFirmware = true;
}
