# Home

The path `./home` is the location for the Home Manager configurations for the user[s] of the system[s].

Each user has a folder, an in this folder there is a file for each system the user should be using.

```sh
 tree ./home -L 3
./home
└── fs
    ├── common
    │   ├── core
    │   └── optional
    ├── host-template.nix
    └── magnus.nix
```
- `magnus.nix` is one host that the user `fs` should have a home on
- `common` folder containse settings applicable to all hosts; within this `core` is required, `optional` (and/or any of it's subfolders) can be added or ignored for the `fs` user on the `magnus` host
