#!/usr/bin/env bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
VIOLET='\033[0;35m'
NC='\033[0m'

# Print functions
print_header() {
  echo -e "${VIOLET}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "${VIOLET} ${1}${NC}"
  echo -e "${VIOLET}═══════════════════════════════════════════════════════════════${NC}"
}

print_error() {
  echo -e "${RED}✗ Error: ${1}${NC}"
}

print_success() {
  echo -e "${GREEN}✓ ${1}${NC}"
}

print_info() {
  echo -e "${BLUE}ℹ ${1}${NC}"
}

print_header "Nyramu's NixOS dotfiles - Installation script"
echo ""
echo -e "${BLUE}Welcome! This installer will set up your NixOS config.${NC}"
echo ""
sleep 2

# Verify NixOS
print_header "System Verification"
echo ""

if grep -qi nixos /etc/os-release; then
  print_success "Running on NixOS"
else
  print_error "This installer requires NixOS"
  exit 1
fi

print_header "Profile selection"
echo ""

# Load profiles
declare -A profiles
for profile in profiles/*; do
  profile=$(basename "$profile")
  if [ "$profile" = "base" ]; then continue; fi
  profiles["$profile"]="$profile"
done

echo "Select profile:"
for profile in "${profiles[@]}"; do
  echo -e "  - ${GREEN}${profile}${NC}"
done

echo ""
printf "Selection: "
read -r profile

if [[ ! -v profiles["$profile"] ]]; then
  print_error "profile ${profile} does not exist, aborting"
  exit 1
fi

echo ""
echo -e "${YELLOW}WARNING: do you need to generate hardware-configuration.nix?${NC}"
printf "[y/N]: "
read -r generate

if [[ $generate = "y" ]]; then
  sudo nixos-generate-config --show-hardware-config > profiles/"${profile}"/hardware-configuration.nix
fi

echo ""
print_header "Profile installation"
echo ""
print_info "Installing $profile profile"
echo ""

sudo nixos-rebuild switch --option extra-experimental-features "nix-command flakes pipe-operators" --flake ~/.dotfiles#"$profile"

echo ""
print_success "System part of the $profile profile has been installed"
echo ""

nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.dotfiles#"$profile"

echo ""
print_success "Home-manager part of the $profile profile has been installed"
echo ""

mkdir -p ~/Music/Lyrics/
mkdir -p ~/Music/Playlists/
mkdir -p ~/Desktop/
mkdir -p ~/Downloads/
mkdir -p ~/Documents/  
mkdir -p ~/Videos/Recordings/
mkdir -p ~/Pictures/Screenshots/
mkdir -p ~/Games/

print_success "Home user directories have been created"
echo ""

print_success "Installation finished, you can reboot now"
