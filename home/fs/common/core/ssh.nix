{ ... }:
{
  programs.ssh = {
    enable = true;

    # req'd for enabling yubikey-agent
    extraConfig = ''
      AddKeysToAgent yes
    '';

    matchBlocks = {
      "git" = {
        host = "gitlab.com github.com";
        user = "git";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          # "~/.ssh/id_yubikey" # This is an auto symlink to whatever yubikey is plugged in. See hosts/common/optional/yubikey #TODO: sort out yubikey frist
          # "~/.ssh/id_manu" # fallback to id_manu if yubis aren't present
          "~/.ssh/id_fs_git"
        ];
      };
      "pve" = {
        host = "10.0.40.10 10.0.40.11 10.0.40.12";
        user = "root";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          # "~/.ssh/id_yubikey" # This is an auto symlink to whatever yubikey is plugged in. See hosts/common/optional/yubikey #TODO: sort out yubikey frist
          # "~/.ssh/id_manu" # fallback to id_manu if yubis aren't present
          "~/.ssh/id_ed25519"
        ];
      };
      "devops0" = {
        host = "10.0.40.100";
        user = "root";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          # "~/.ssh/id_yubikey" # This is an auto symlink to whatever yubikey is plugged in. See hosts/common/optional/yubikey #TODO: sort out yubikey frist
          # "~/.ssh/id_manu" # fallback to id_manu if yubis aren't present
          "~/.ssh/id_debian12"
        ];
      };
      "fulgrim" = {
        host = "10.0.20.202";
        user = "root";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          # "~/.ssh/id_yubikey" # This is an auto symlink to whatever yubikey is plugged in. See hosts/common/optional/yubikey #TODO: sort out yubikey frist
          # "~/.ssh/id_manu" # fallback to id_manu if yubis aren't present
          "~/.ssh/id_root_fulgrim"
        ];
      };
      "magnus" = {
        host = "10.0.20.201";
        user = "root";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = [
          # "~/.ssh/id_yubikey" # This is an auto symlink to whatever yubikey is plugged in. See hosts/common/optional/yubikey #TODO: sort out yubikey frist
          # "~/.ssh/id_manu" # fallback to id_manu if yubis aren't present
          "~/.ssh/id_root_magnus"
        ];
      };

    };
    # FIXME: This should probably be for git systems only?
    #controlMaster = "auto";
    #controlPath = "~/.ssh/sockets/S.%r@%h:%p";
    #controlPersist = "60m";

    #extraConfig = ''
    #Include config.d/*
    #'';
  };
  #  home.file.".ssh/sockets/.keep".text = "# Managed by Home Manager";
}
