{ self, lib, ... }:
{
  flake.modules.homeManager = {
    miscellaneous.imports = [ self.modules.homeManager.hyprlock ];

    hyprlock =
      { config, ... }:

      let
        cfg = config.nyra.miscellaneous.hyprlock;
        inherit (config.lib.stylix) colors;
      in
      {
        options.nyra.miscellaneous.hyprlock = {
          enable = lib.mkEnableOption "Hyprlock" // {
            default = config.nyra.desktops.hyprland.enable;
          };
        };

        config = lib.mkIf (cfg.enable) {

          programs.hyprlock = {
            enable = true;
            settings = {
              general = {
                hide_cursor = true;
              };

              animations = {
                enabled = true;
                bezier = [
                  "linear, 1, 1, 0, 0"
                ];
                animation = [
                  "fadeIn, 1, 5, linear"
                  "fadeOut, 1, 5, linear"
                  "inputFieldDots, 1, 2, linear"
                ];
              };

              background = {
                path = lib.mkForce "screenshot";
                brightness = 0.6;
                blur_passes = 2;
                blur_size = 3;
              };

              input-field = lib.mkForce [
                {
                  size = "500, 70";
                  position = "0, -150";
                  monitor = "";
                  dots_center = true;
                  fade_on_empty = true;
                  outline_thickness = 5;
                  placeholder_text = "Enter your password...";
                  shadow_passes = 2;
                  outer_color = "rgb(${colors.base03})";
                  inner_color = "rgb(${colors.base00})";
                  font_color = "rgb(${colors.base05})";
                  fail_color = "rgb(${colors.base08})";
                  check_color = "rgb(${colors.base0A})";
                  fail_text = "❌ Invalid Password";
                }
              ];

              label = [
                {
                  monitor = "";
                  text = "cmd[update:1000] echo \"$(date +'%H:%M:%S')\"";
                  font_size = 90;
                  position = "0, 300";
                  halign = "center";
                  valign = "center";
                  color = "rgb(${colors.base0B})";
                }
                {
                  monitor = "";
                  text = "cmd[update:1000] echo \"$(date +'%A, %d/%m/%Y')\"";
                  font_size = 24;
                  position = "0, 220";
                  halign = "center";
                  valign = "center";
                  color = "rgb(${colors.base0A})";
                }
              ];
            };
          };
        };
      };
  };
}
