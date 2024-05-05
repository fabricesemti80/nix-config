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

   # VSCode server to allow connection in eeditor - "https://github.com/nix-community/nixos-vscode-server"
    vscode-server = {
      url =  "github:nix-community/nixos-vscode-server";
    };

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
  } @ inputs: 
  
  let
    inherit (self) outputs;
    
    #################### ? -------------------------------------------------------------------> Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    inherit (nixpkgs) lib;

    #################### ? -------------------------------------------------------------------> Load custom stuff
    # variables from ./var
    configVars = import ./vars { inherit inputs lib; };
    configLib = import ./lib { inherit lib; };
  
    #################### ? -------------------------------------------------------------------> This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;

  in {

    #TODO: cleanup the next 3 lines - they are replaced in the "Your custom packages.." block
    # # Your custom packages
    # # Accessible through 'nix build', 'nix shell', etc
    # packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    
    # # Formatter for your nix files, available through 'nix fmt'
    # # Other options beside 'alejandra' include 'nixpkgs-fmt'
    # formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
    # TODO change this to something that has better looking output rules
    # Nix formatter available through 'nix fmt' https://nix-community.github.io/nixpkgs-fmt
    formatter = forAllSystems
      (system:
        nixpkgs.legacyPackages.${system}.nixpkgs-fmt
      );

    #################### ? -------------------------------------------------------------------> Your custom packages and modifications
    # Custom modifications/overrides to upstream packages
    overlays = import ./overlays {inherit inputs;};

    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;

    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # Custom packages to be shared or upstreamed.
    packages = forAllSystems
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./pkgs { inherit pkgs; }
      );

    #################### ? -------------------------------------------------------------------> Dev shell
    # Shell configured with packages that are typically only needed when working on or with nix-config.
    devShells = forAllSystems
      (system:
        let pkgs = nixpkgs.legacyPackages.${system};
        in import ./shell.nix { inherit pkgs; }
      );

    #################### NixOS Configurations ####################
    # NixOS configuration entrypoint
    # Building configurations available through `just rebuild` or `nixos-rebuild --flake .#hostname` #FIXME: review  and fix 'just rebuild'

    nixosConfigurations = {
      magnus = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs outputs configVars configLib nixpkgs; };
        modules = [
          # Enable VSCode
          vscode-server.nixosModules.default          
          # > Our main nixos configuration file <
          ./hosts/magnus
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
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
