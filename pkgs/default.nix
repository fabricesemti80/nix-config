# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  cd-gitroot = pkgs.callPackage ./cd-gitroot { };
  zhooks = pkgs.callPackage ./zhooks { };
  zsh-term-title = pkgs.callPackage ./zsh-term-title { };  
}


