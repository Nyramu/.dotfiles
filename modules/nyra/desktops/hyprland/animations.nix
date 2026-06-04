{ lib, ... }:
{
  flake.modules.homeManager.hyprland =
    { performance, ... }:

    let
      enableAnimation = performance != "potato";
    in
    {
      hyprnix.settings = {
        animation = lib.mapAttrs (_: v: v // { enabled = enableAnimation; }) {
          borderangle = {
            speed = 20;
            bezier = "linear";
            style = "loop";
          };
          windowsIn = {
            speed = 5;
            bezier = "holo";
            style = "slide";
          };
          windowsOut = {
            speed = 4;
            bezier = "holo";
            style = "popin 100%";
          };
          windowsMove = {
            speed = 5;
            bezier = "holo";
            style = "slide";
          };
          fade = {
            speed = 5;
            bezier = "data";
          };
          layers = {
            speed = 5;
            bezier = "holo";
            style = "fade";
          };
          workspaces = {
            speed = 6;
            bezier = "holo";
            style = "slidevert";
          };
          specialWorkspace = {
            speed = 6;
            bezier = "holo";
            style = "slidevert";
          };
        };
        curve = {
          bezier = {
            holo = [
              0.23
              1
              0.32
              1
            ];

            data = [
              0.16
              1
              0.3
              1
            ];

            linear = [
              0
              0
              1
              1
            ];
          };
        };
      };
    };
}
