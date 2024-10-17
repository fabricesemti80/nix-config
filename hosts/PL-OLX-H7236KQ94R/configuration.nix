{pkgs, ...}: {
  # Basic system settings
  system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  system.defaults.NSGlobalDomain.AppleKeyboardUIMode = 3;
  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;

  # Install some basic packages
  environment.systemPackages = with pkgs; [
    lazydocker
  ];

  # Enable some system services
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Add ability to use TouchID for sudo
  security.pam.enableSudoTouchIdAuth = true;

  # Set up user
  users.users.alexander-nabokikh = {
    name = "alexander.nabokikh";
    home = "/Users/alexander.nabokikh";
  };

  # Used for backwards compatibility, please read the changelog before changing.
  system.stateVersion = 5;
}
