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

print_header "Host selection"
echo ""

# Load hosts
declare -A hosts
for host in modules/hosts/*; do
  host=$(basename "$host")
  hosts["$host"]="$host"
done

echo "Select host:"
for host in "${hosts[@]}"; do
  echo -e "  - ${GREEN}${host}${NC}"
done

echo ""
printf "Selection: "
read -r host

if [[ ! -v hosts["$host"] ]]; then
  print_error "host ${host} does not exist, aborting"
  exit 1
fi

echo ""
echo -e "${YELLOW}WARNING: do you need to generate hardware-configuration.nix?${NC}"
printf "[y/N]: "
read -r generate

if [[ $generate = "y" ]]; then
  sudo nixos-generate-config --show-hardware-config > modules/hosts/"${host}"/_hardware-configuration.nix
fi

echo ""
print_header "Host installation"
echo ""
print_info "Installing $host host"
echo ""

sudo nixos-rebuild switch --option extra-experimental-features "nix-command flakes pipe-operators" --flake ~/.dotfiles#"$host"

echo ""
print_success "System part of the $host host has been installed"
echo ""

nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.dotfiles#"$host"

echo ""
print_success "Home-manager part of the $host host has been installed"
echo ""

print_success "Home user directories have been created"
echo ""

print_success "Installation finished, you can reboot now"
