#!/bin/bash

cp /home/trbiv/nixos-config/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch
