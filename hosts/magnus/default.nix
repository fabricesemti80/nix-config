# This is your system's configuration file.
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{ inputs
, outputs
, config
, configLib
, ...
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
    #################### Hardware Modules ####################
    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    #################### Required Configs ####################
    ./hardware-configuration.nix
    (configLib.relativeToRoot "hosts/common/core")

    #################### Host-specific Optional Configs ####################
    # (configLib.relativeToRoot "hosts/common/optional/yubikey")
    (configLib.relativeToRoot "hosts/common/optional/docker.nix")

    # (configLib.relativeToRoot "hosts/common/optional/services/clamav.nix") # depends on optional/msmtp.nix
    # (configLib.relativeToRoot "hosts/common/optional/msmtp.nix") # required for emailing clamav alerts
    (configLib.relativeToRoot "hosts/common/optional/services/openssh.nix")

    (configLib.relativeToRoot "hosts/common/optional/packages")

    (configLib.relativeToRoot "hosts/common/optional/devtools") #NOTE: only for dev workstations


    # # Desktop
    # (configLib.relativeToRoot "hosts/common/optional/services/greetd.nix") # display manager #FIXME: used for Hyper - no use on VM
    # (configLib.relativeToRoot "hosts/common/optional/hyprland.nix") # window manager #FIXME: used for Hyper - no use on VM

    #   #################### Users to Create ####################
    (configLib.relativeToRoot "hosts/common/users/fs")

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

  # nix = let
  #   flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  # in {
  #   settings = {
  #     # Enable flakes and new 'nix' command
  #     experimental-features = "nix-command flakes";
  #     # Opinionated: disable global registry
  #     flake-registry = "";
  #     # Workaround for https://github.com/NixOS/nix/issues/9574
  #     nix-path = config.nix.nixPath;
  #   };
  #   # Opinionated: disable channels
  #   channel.enable = false;

  #   # Opinionated: make flake registry and nix path match flake inputs
  #   registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
  #   nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  # };

  # # https://nixos-and-flakes.thiscute.world/best-practices/remote-deployment#remote-deployment
  # security.sudo.wheelNeedsPassword = false;

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # # Set your time zone.
  # time.timeZone = "Europe/London";

  # # Select internationalisation properties.
  # i18n.defaultLocale = "en_GB.UTF-8";

  # i18n.extraLocaleSettings = {
  #   LC_ADDRESS = "en_GB.UTF-8";
  #   LC_IDENTIFICATION = "en_GB.UTF-8";
  #   LC_MEASUREMENT = "en_GB.UTF-8";
  #   LC_MONETARY = "en_GB.UTF-8";
  #   LC_NAME = "en_GB.UTF-8";
  #   LC_NUMERIC = "en_GB.UTF-8";
  #   LC_PAPER = "en_GB.UTF-8";
  #   LC_TELEPHONE = "en_GB.UTF-8";
  #   LC_TIME = "en_GB.UTF-8";
  # };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # # set custom autologin options. see greetd.nix for details
  # # TODO is there a better spot for this?
  # autoLogin.enable = true; #FIXME: used for Hyper - no use on VM
  # autoLogin.username = "fs"; #FIXME: used for Hyper - no use on VM
  services.getty.autologinUser = "fs";

  services.gnome.gnome-keyring.enable = true;
  # TODO enable and move to greetd area? may need authentication dir or something?
  # services.pam.services.greetd.enableGnomeKeyring = true;

  # Enable VSCode Server
  services.vscode-server.enable = true;

  networking = {
    hostName = "magnus";
    # networkmanager.enable = true;
    enableIPv6 = false;
  };




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
      extraGroups = [ "wheel" ];
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

  # VirtualBox settings for Hyprland to display correctly
  environment.sessionVariables.WLR_NO_HARDWARE_CURSORS = "1";
  environment.sessionVariables.WLR_RENDERER_ALLOW_SOFTWARE = "1";

  # Fix to enable VSCode to successfully remote SSH on a client to a NixOS host
  # https://nixos.wiki/wiki/Visual_Studio_Code # Remote_SSH
  programs.nix-ld.enable = true;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}
