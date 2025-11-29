{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.home.apps.miscellaneous.yazi;
in
{
  options.nyra.home.apps.miscellaneous.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = {
    programs.yazi = {
      enable = cfg.enable;
      enableZshIntegration = config.nyra.home.shells.zsh.enable;
      settings = {
        mgr = {
          sort_by = "mtime";
          sort_sensitive = false;
          sort_dir_first = true;
          linemode = "size_and_mtime";
          show_hidden = true;
        };
        preview.wrap = "yes";
        opener = {
          edit = [
            { "run" = "nvim \"$@\""; "block" = true; }
          ];
          play = [
            # TODO: Fix
            { "run" = "rmpc clear && rmpc add '$0' && rmpc play"; "orphan" = true; }
          ];
        };
      };
    };
  };
}
