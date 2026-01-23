{ config, ... }:

let
  cfg = config.nyra.shells.nushell;
in
{
  programs.nushell = {
    enable = cfg.enable;
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
}
