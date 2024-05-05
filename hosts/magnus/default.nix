# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosModules.example

    # Or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.common-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # # Disable if you don't want unfree packages
      # allowUnfree = true; #NOTE: defined in home config
    };
  };

  nix = let
    flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Opinionated: disable global registry
      flake-registry = "";
      # Workaround for https://github.com/NixOS/nix/issues/9574
      nix-path = config.nix.nixPath;
    };
    # Opinionated: disable channels
    channel.enable = false;

    # Opinionated: make flake registry and nix path match flake inputs
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # https://nixos-and-flakes.thiscute.world/best-practices/remote-deployment#remote-deployment
  security.sudo.wheelNeedsPassword = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "fs";

  # Enable VSCode Server
  services.vscode-server.enable = true;

  networking.hostName = "magnus";

  # Allow unfree packages systemwide
  nixpkgs.config.allowUnfree = true;

  # System-wide packages
  environment.systemPackages = [       
    pkgs.age
    pkgs.direnv
    pkgs.duf
    pkgs.git
    pkgs.go-task
    pkgs.home-manager
    pkgs.just
    pkgs.libiconv
    pkgs.nix
    pkgs.nixpkgs-fmt
    pkgs.pre-commit
    pkgs.ssh-to-age
    pkgs.sops    
  ];

  # TODO: Configure your system-wide user settings (groups, etc), add more users as needed.
  users.users = {
    fs = {
      # TODO: You can set an initial password for your user.
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      ## initialPassword = "correcthorsebatterystaple";
      isNormalUser = true;
      description = "Fabrice Semti";
      openssh.authorizedKeys.keys = [
	      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIToeo6ZJO0VXyAKlFuoq7e3GFfa9xmb7UhaI6LGHc2t"
      ];
      extraGroups = ["wheel"];
    };
    root = {
         openssh.authorizedKeys.keys = [
        # Allow connect with your ssh key as the `root` account - https://nixos-and-flakes.thiscute.world/best-practices/remote-deployment#remote-deployment
	      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIToeo6ZJO0VXyAKlFuoq7e3GFfa9xmb7UhaI6LGHc2t"
      ];   
    };
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
