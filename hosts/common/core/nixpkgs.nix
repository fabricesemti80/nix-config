{ outputs, ... }: {

  /* ------------------------------------ nix package defaults ------------------------------------ */

  nixpkgs = {
    # you can add global overlays here
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
    };
  };


}
