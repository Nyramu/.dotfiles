echo "IMPORTANT"
echo "Remember to set the hardware configuration file in the desired profile (profiles/<name>/hardware-configuration.nix)"
echo "To generate it you can use:"
echo "    sudo nixos-generate-config --show-hardware-config"
echo "or just copy it from etc/nixos/hardware-configuration.nix"
echo ""

printf "Did you do it? [y/N]"
read -r proceed

case $proceed in
  "y");;
  "Y");;
  *)
    echo "Aborting install"
    exit 1
esac

echo "Please select which profile to install:"
echo "  - main"
echo "  - potato"
echo ""

printf "input: "
read -r profile

case $profile in
  "main");;
  "potato");;
  *)
    echo "Invalid input, aborting"
    exit 1
esac

sudo nixos-rebuild switch --flake ~/.dotfiles#"$profile"

nix run home-manager/master --extra-experimental-features nix-command --extra-experimental-features flakes -- switch --flake ~/.dotfiles#"$profile"

mkdir -p ~/Music/Lyrics
mkdir -p ~/Music/Playlists
mkdir -p ~/Desktop/
mkdir -p ~/Downloads/  
mkdir -p ~/Videos/Recordings
mkdir -p ~/Pictures/Screenshots
mkdir -p ~/Games/

clear

echo "Installation finished, you can reboot now"
echo "-------------------------------------------"
echo "Remember to set SSH:"
echo "1.    ssh-keygen -t ed25519 -C 'your_email@example.com'"
echo "2.    $ eval '$(ssh-agent -s)'"
echo "3.    ssh-add ~/.ssh/id_ed25519"
echo "4.    $ cat ~/.ssh/id_ed25519.pub"
echo "5.    Then select and copy the contents of the id_ed25519.pub file"
echo "      displayed in the terminal to your clipboard"
echo ""
echo "6.    Add the key on GitHub!"

