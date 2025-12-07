{ config, lib, ... }: with lib;

let
  shellCfg = config.nyra.home.shells;
  cfg = config.nyra.home.apps.miscellaneous.yazi;
in
{
  options.nyra.home.apps.miscellaneous.yazi = {
    enable = mkEnableOption "yazi";
  };

  config = {
    programs.yazi = {
      enable = cfg.enable;
      enableZshIntegration = shellCfg.zsh.enable;
      settings = {
        mgr = {
          sort_by = "mtime";
          sort_sensitive = false;
          sort_dir_first = true;
          linemode = "size_and_mtime"; #TODO: Fix
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
