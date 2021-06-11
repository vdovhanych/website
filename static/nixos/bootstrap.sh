#!/usr/bin/env bash
echo
echo Bootstraping the installer, hold on...
echo
nix-env -iA nixos.diceware nixos.wget
wget -q https://dovh.cz/nixos/install.sh -O /etc/nixos/install.sh && chmod +x /etc/nixos/install.sh
bash /etc/nixos/install.sh
