{ inputs
, outputs
, lib
, config
, configLib
, pkgs
, ...
}: {
  # System packages
  environment = {
    systemPackages = with pkgs; [
      # System Wide Packages

      #TODO: move some of these to user0only!

      ### User home management
      home-manager # ? Manage your home

      ### Security
      age # ? (Simple, modern file encryption tool)
      ssh-to-age # ? Convert SSH keys to AGE
      sops # ? (Simple and flexible tool for managing secrets)
      # gnupg # ? (GNU Privacy Guard - encryption and signing tool)
      # pinentry-qt # ? Qt-based PIN or passphrase entry dialog for GnuPG
      # pinentry-qt # ? (Qt-based PIN or passphrase entry dialog for GnuPG)

      ## Terminal enhancement
      ranger # ? (Console file manager with VI key bindings)
      neovim # ? (Text editor that seeks to improve upon Vim)
      tree # ? (Recursive directory listing command)
      tmux # ? (Terminal multiplexer)

      ### Utilities:
      direnv # ? (Environment switcher for the shell)

      ### Command-line Utilities:
      bat # ? (A cat(1) clone with syntax highlighting and Git integration)
      btop # ? (Resource monitor)
      # cmatrix # ? (Matrix screensaver)
      cowsay # ? (Program that generates ASCII pictures of a cow with a message)
      duf # ? (Disk usage/free utility)
      # exa # for system state <= 23.05  # ? (Command-line utility for task automation)
      eza # for system state > 23.05 # ? (Command-line utility for task automation)

      fzf # ? (Command-line fuzzy finder)
      lolcat # ? (Colorize text in the terminal)
      # man-pages # ? (Linux manual pages)
      # nano # ? (Text editor for Unix-like operating systems)
      neofetch # ? (Command-line system information tool)
      tailscale # ? (Mesh VPN service for easy and secure network access)
      dig # ? (DNS lookup utility)
      curl # ? (Command-line tool for making HTTP requests)
      httpie # ? (Command-line HTTP client)
      wget # ? (Command-line utility to download files from the web)

    ];
  };
}
