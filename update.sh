#!/bin/bash

sudo cp ~/nixos-config/configuration.nix /etc/nixos/configuration.nix
sudo nixos-rebuild switch
