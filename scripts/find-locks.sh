#!/bin/sh

for file in $(ls /nix/store/); do
	test -f /nix/store/${file}.lock && echo "/nix/store/$file.lock"
done

# ? https://github.com/NixOS/nix/issues/3017
