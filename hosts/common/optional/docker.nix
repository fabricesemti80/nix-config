{ pkgs
, ...
}: {
  # System packages
  environment = {
    systemPackages = with pkgs; [
      docker # ? Container management
    ];
  };
  # Docker needs this - https://nixos.wiki/wiki/Docker
  virtualisation.docker.enable = true;

}
