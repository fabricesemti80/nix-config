{
# inputs,
# outputs,
# lib,
# config,
pkgs, vars, ... }:

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

in {
  # home.file.".ssh/id_ed25519.pub".text = "${vars.pubKey}";
  # home.file.".ssh/allowed_signers".text = "${vars.pubKey}";

  programs.git = {
    enable = true;
    userName = "Fabrice";
    userEmail = "fabrice@fabricesemti.com";
    # signing.key = "79C2C5311CCE42F5"; # gpg - -list-key
    aliases = gitAliases;
    lfs = { enable = true; };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        # editor = "vim";
        autocrlf = "input";
      };

      # # ? ref: "https://jeppesen.io/git-commit-sign-nix-home-manager-ssh/"
      # commit.gpgsign = true;
      # gpg.format = "ssh";
      # gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      # user.signingkey = "~/.ssh/id_ed25519.pub";

      pull.rebase = true;
      rebase.autoStash = true;
    };
    diff-so-fancy = {
      enable = true;
      changeHunkIndicators = true;
    };

    ignores = [ ".vscode/**" ];
  };
}
