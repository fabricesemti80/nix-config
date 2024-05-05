{
  description = "Fabrice Semti's Nix config";

  inputs = {
    
    #################### ? -------------------------------------------------------------------> Official NixOS and HM Package Sources 

    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-23.11";
    };

    nixpkgs-unstable = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    hardware = {
      url = "github:nixos/nixos-hardware";
    };

    # Home manager
    home-manager = {
        url = "github:nix-community/home-manager/release-23.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    #################### ? ------------------------------------------------------------------->  Utilities 

    # Declarative partitioning and formatting
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management. See ./docs/secretsmgmt.md
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url =
      "github:nix-community/nixos-vscode-server"; # VSCode Server support - "https://github.com/nix-community/nixos-vscode-server"


    #################### ? -------------------------------------------------------------------> Personal Repositories 

    # Private secrets repo.  See ./docs/secretsmgmt.md
    # Authenticate via ssh and use shallow clone
    nix-secrets = {
      url = "git+ssh://git@gitlab.com/fabricesemti/nix-secrets.git?ref=main&shallow=1";
      flake = false;
    };

  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    vscode-server,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME replace with your hostname
      magnus = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          # Enable VSCode
          vscode-server.nixosModules.default          
          # > Our main nixos configuration file <
          ./nixos/configuration.nix
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME replace with your username@hostname
      "fs@magnus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          # > Our main home-manager configuration file <
          ./home-manager/home.nix
        ];
      };
    };
  };
}
