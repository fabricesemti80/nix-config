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

      ### NIX tools
      deadnix # ? Find and remove unused code in .nix source files
      nix
      nix-info # ? (Nix package manager information)
      nixfmt # ? (Formatter for Nix code)
      nixpkgs-fmt # ? (Formatter for Nixpkgs code)

      ### Development Tools:
      ansible
      docker # ? Container management
      git # ? (Version control system)
      go-task # ? (Task runner / build tool)
      # hugo # ? (Static site generator)
      httpie # ? (Command-line HTTP client)
      just # ? Make-alternative
      libiconv # ? Encoding conversion
      jq # ? (Lightweight and flexible command-line JSON processor)
      pre-commit # ? Check code before commiting
      ripgrep # ? (Fast and efficient text search tool)
      # wget # ? (Command-line utility to download files from the web)

      #   ansible-language-server
      #   ansible-lint
      #   dockerlinter
      #   gitlint
      #   eslint
      #   shellcheck
      #   cspell
      #   clangtidy
      #   clang-format
      #   prettier
      #   cspell
      #   nixfmt
      #   alejandra
      #   black
      #   flake8
      #   dprint
      #   vimls
      #   vint

      ### Programming Language:
      # go # ? (Go programming language)

    ];
  };
}
