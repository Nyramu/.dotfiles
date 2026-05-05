{ lib, ... }:

let
  inherit (lib.types)
    str
    path
    ;
in

{
  options.nyra.settings = {
    hostname = lib.mkOption {
      type = str;
      default = "nixos";
      description = "set your host name";
    };
    username = lib.mkOption {
      type = str;
      default = "nyramu";
      description = "set your username";
    };
    name = lib.mkOption {
      type = str;
      default = "Nyramu";
      description = "set your name";
    };
    email = lib.mkOption {
      type = str;
      default = "107689027+Nyramu@users.noreply.github.com";
      description = "set your email";
    };
    pfp = lib.mkOption {
      type = path;
      default = ../../resources/pics/nyramu.png;
      description = "set your profile pic";
    };
    dotfiles = lib.mkOption {
      type = str;
      default = "~/.dotfiles";
      description = "set your dotfiles location";
    };
    monitor = {
      name = lib.mkOption {
        type = str;
        default = "eDP-1";
        description = "set the main monitor name";
      };
      width = lib.mkOption {
        type = str;
        default = "1920";
        description = "monitor's pixel width";
      };
      height = lib.mkOption {
        type = str;
        default = "1200";
        description = "monitor's pixel height";
      };
      refreshRate = lib.mkOption {
        type = str;
        default = "60";
        description = "monitor's refresh rate";
      };
    };
  };
}
