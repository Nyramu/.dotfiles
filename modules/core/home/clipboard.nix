{ self, lib, ... }:
{
  flake.modules.homeManager = {
    core.imports = [ self.modules.homeManager.clipboard ];

    clipboard =
      { wayland, pkgs, ... }:
      {
        services.wl-clip-persist = {
          enable = wayland.enable;
        };

        home.packages =
          with pkgs;
          lib.optionals (wayland.enable) [
            wl-clipboard
          ]
          ++ lib.optionals (wayland.xwayland.enable) [ wl-clipboard-x11 ];
      };
  };
}
