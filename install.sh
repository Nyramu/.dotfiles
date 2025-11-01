#!/bin/sh

#echo "IMPORTANT"
#echo "Remember to set the hardware configuration file in the desired profile (profiles/<name>/hardware-configuration.nix)"
#echo "To generate it you can use:"
#echo "    sudo nixos-generate-config --show-hardware-config"
#echo "or just copy it from etc/nixos/hardware-configuration.nix"
#echo ""

sudo nixos-generate-config --show-hardware-config > ./profiles/main/hardware-configuration.nix

nix flake update ~/.dotfiles

sudo nixos-rebuild switch --flake ~/.dotfiles#system

nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.dotfiles#user

mkdir ~/Music/
mkdir ~/Desktop/
mkdir ~/Downloads/  
mkdir ~/Videos/
mkdir ~/Pictures/
mkdir ~/Games/

clear

echo "Remember to set SSH:"
echo "1.    ssh-keygen -t ed25519 -C \"your_email@example.com\""
echo "2.    $ eval \"$(ssh-agent -s)\""
echo "3.    ssh-add ~/.ssh/id_ed25519"
echo "4.    $ cat ~/.ssh/id_ed25519.pub"
echo "5.    Then select and copy the contents of the id_ed25519.pub file"
echo "      displayed in the terminal to your clipboard"
echo ""
echo "6.    Add the key on GitHub!"

