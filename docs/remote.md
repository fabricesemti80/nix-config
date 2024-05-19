# Remote rebuild

```nix
nixos-rebuild switch --impure --use-remote-sudo --build-host localhost --target-host "10.0.20.202" --flake ".#fulgrim"
```
