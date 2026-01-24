{ lib, ... }:

{
  options.nyra.settings = {
    hostname = lib.mkOption {
      type = lib.types.str;
      default = "nixos";
      description = "set your host name";
    };
    username = lib.mkOption {
      type = lib.types.str;
      default = "nyramu";
      description = "set your username";
    };
    name = lib.mkOption {
      type = lib.types.str;
      default = "Nyramu";
      description = "set your name";
    };
    email = lib.mkOption {
      type = lib.types.str;
      default = "107689027+Nyramu@users.noreply.github.com";
      description = "set your email";
    };
    dotfiles = lib.mkOption {
      type = lib.types.str;
      default = "~/.dotfiles";
      description = "set your dotfiles location";
    };
  };
}
