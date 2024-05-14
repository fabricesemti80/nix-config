{ pkgs, configVars, ... }:

let
  gitAliases = {
    l = ''
      log --pretty=format:"%C(yellow)%h\ %ad%Cred%d\ %Creset%s%Cblue\ [ %cn ]" --decorate --date=short'';
    a = "add";
    ap = "add -p";
    c = "commit --verbose";
    ca = "commit -a --verbose";
    cm = "commit -m";
    cam = "commit -a -m";
    m = "commit --amend --verbose";
    d = "diff";
    ds = "diff --stat";
    dc = "diff --cached";
    s = "status -s";
    co = "checkout";
    cob = "checkout -b";
    # # list branches sorted by last modified
    b =
      "!git for-each-ref --sort='-authordate' --format='%(authordate)%09%(objectname:short)%09%(refname)' refs/heads | sed -e 's-refs/heads/--'";
    # # list aliases
    la = "!git config -l | grep alias | cut -c 7-";
    # # https://davidwalsh.name/awesome-git-aliases
    dad = "!curl https://icanhazdadjoke.com/ && echo";
    last = "log - 1 HEAD";
  };

in
{

  home.file.".ssh/allowed_signers".text =
    "* ${builtins.readFile /home/${configVars.username}/.ssh/id_fs_git.pub}";

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "${configVars.gitHandle}";
    userEmail = "${configVars.gitEmail}";
    aliases = gitAliases;

    extraConfig = {
      init.defaultBranch = "main";
      url = {
        "ssh://git@github.com" = {
          insteadOf = "https://github.com";
        };
        "ssh://git@gitlab.com" = {
          insteadOf = "https://gitlab.com";
        };
        autocrlf = "input";
      };

      user.signingkey = "~/.ssh/id_fs_git.pub";
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";

      # user.signing.key = "41B7B2ECE0FAEF890343124CE8AA1A8F75B56D39";
      # commit.gpgSign = false;
      # gpg.program = "${config.programs.gpg.package}/bin/gpg2"

      pull.rebase = true;
      rebase.autoStash = true;

    };
    # enable git Large File Storage: https://git-lfs.com/
    # lfs.enable = true;
    ignores = [
      ".direnv"
      "result"
      ".vscode/**"
    ];
    lfs = { enable = true; };

  };
}
