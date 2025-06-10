#!/bin/bash

cp ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch
