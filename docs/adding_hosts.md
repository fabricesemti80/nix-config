# To add a new host

## Create a NixOS installation.

Use desktop-based or minimal install.

## Post-install on the new machine

In order to be able to connect to the host via SSH, a few things should be done:

- enable SSH

edit the NixOS configuration (`/etc/nixos/configuration`) using `sudo nano` and uncomment 

```nix
...
  services.openssh.enable = true;
...  
```

- enable nix commands and flake

edt the same file and add in

```nix
...
 nix.settings.experimental-features = [ "nix-command flakes" ];
...
```

- activate the configuration using 

```sh
sudo nixos-rebuild switch
```

- connect using SSH + password

- create a folder for your repositories and enter to this

```sh
[fabrice@nixos:~]$ mkdir projects

[fabrice@nixos:~]$ cd projects

[fabrice@nixos:~/projects]$ pwd
/home/fabrice/projects

[fabrice@nixos:~/projects]$
```

- create a `~/.ssh` folder and copy your ssh key for Github (or Gitlab if you use it) into your ~/.ssh folder somehow (ie. copy from another machine, USB key, etc.)

```sh
scp ~/.ssh/id_fs_git fabrice@10.0.20.89:/home/fabrice/.ssh/.
...
```

- add this to your ~/.ssh/config:

```sh
   Host gitlab.com github.com
       ForwardAgent yes
       IdentitiesOnly yes
       User git
       IdentityFile ~/.ssh/id_fs_git
```

> optionally test with `ssh -T git@github.com` if you can authenticate

> note: replace `id_fs_git` with your private key

- run a temp shell with git

```sh
nix-shell -p git 
```

- clone your repos and switch to the correct branch of your nix config

```sh
[nix-shell:~/projects]$ git clone git@github.com:fabricesemti80/nix-config.git
Cloning into 'nix-config'...
remote: Enumerating objects: 622, done.
remote: Counting objects: 100% (246/246), done.
remote: Compressing objects: 100% (167/167), done.
remote: Total 622 (delta 94), reused 167 (delta 50), pack-reused 376
Receiving objects: 100% (622/622), 182.72 KiB | 912.00 KiB/s, done.
Resolving deltas: 100% (235/235), done.

[nix-shell:~/projects]$ git clone  git@gitlab.com:fabricesemti/nix-secrets.git
Cloning into 'nix-secrets'...
remote: Enumerating objects: 115, done.
remote: Counting objects: 100% (90/90), done.
remote: Compressing objects: 100% (83/83), done.
remote: Total 115 (delta 47), reused 5 (delta 5), pack-reused 25 (from 1)
Receiving objects: 100% (115/115), 38.61 KiB | 38.61 MiB/s, done.
Resolving deltas: 100% (47/47), done.

[nix-shell:~/projects]$ cd nix-config/

[nix-shell:~/projects/nix-config]$ git checkout dev
branch 'dev' set up to track 'origin/dev'.
Switched to a new branch 'dev'
```

- `nix develop` to start a shell with the neccesary tools included

- `just age-key` to get a new key of this system

## Work on an exiting machine (with access of the repos)

### Update secrtets on an exiting server with the repo access
- add the public key displayed to your nix-secrets repo-s `.sops.yaml` file _on another machine that has access to this repo_ and rekey _there_
(ideally )

```sh

# have this folder structure
❯ tree -L 1
.
├── nix-config
└── nix-secrets

# enter the nix-config repo
❯ cd nix-config

# this command will update keys and checks in the repo
❯ just rekey   
```


### Edit flake file 

Edit the `flake.nix` file to create a new block inside the `nixosConfigurations`.

```nix
    nixosConfigurations = {
      ...
      /* ---------------------------------------- the second a proxmox vm ---------------------------------------- */
      fulgrim = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        # specialArgs = { inherit inputs outputs configVars configLib nixpkgs; };
        modules = [
          # Home Manager
          home-manager.nixosModules.home-manager{
            home-manager.extraSpecialArgs = specialArgs;
          }          
          # Enable VSCode
          vscode-server.nixosModules.default          
          # > Our main nixos configuration file <
          ./hosts/fulgrim
        ];
      };      
    };
```

### Create a new configs for this machine

For example by taking an existing one and update where needed

```sh
cp -r  ./hosts/magnus ./hosts/fulgrim
```

> note: when updating, at the minimum make sure to replace the contents of `hardware-configuration.nix` with the one on the new machine; do it on the old host or on the new host after cloning the repository!!

### Create a new home configuration

Copy an existing one and edit

```sh
❯ cp home/fs/magnus.nix home/fs/fulgrim.nix
# ... then edit the file
```

### Update / rebuild the flake 

Then push to the git repo and move on to the new host

## On the new host again




