{ config, lib, ... }:

let
  cfg = config.nyra.shells;
in
{
  options.nyra.shells.nushell = {
    enable = lib.mkEnableOption "nushell";
  };

  config = {
    nyra.shells.nushell.enable = lib.mkDefault (cfg.default == "nushell");
    programs.nushell = {
      enable = cfg.nushell.enable;
      extraConfig = ''
        $env.config = {
          # to hide default banner
          show_banner: false,

          # needed to make direnv work automatically
          hooks: {
            pre_prompt: [{ ||
              if (which direnv | is-empty) {
                return
              }

              direnv export json | from json | default {} | load-env
            }]
          }
        }
      '';
    };
  };
}
