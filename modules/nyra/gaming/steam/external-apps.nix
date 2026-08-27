{ self, lib, ... }:
{
  flake.modules.nixos = {
    gaming.imports = [ self.modules.nixos.steam ];

    steam =
      { config, pkgs, ... }:

      let
        cfg = config.nyra.gaming;
      in
      {
        programs.steam.config.nonSteamApps = {
          "The Legend of Zelda: Breath of the Wild" = lib.mkIf (cfg.cemu.ukmm.enable) {
            seed = "The Legend of Zelda: Breath of the Wild";
            desktopEntry.enable = true;
            allowOverlay = false;
            target = lib.getExe cfg.cemu.package;

            args = [
              "-g"
              "$GAMES/Cemu/BoTW/code/U-King.rpx"
              "-f"
            ];

            artwork = {
              icon = pkgs.fetchurl {
                url = "https://cdn2.steamgriddb.com/icon/af2566f8377b5ae9c13f3dac132297f4.png";
                hash = "sha256-5thQYYCqPzBag8yUZwSjd9Clg0qsyQTUlacAzmlSOFA=";
              };
              cover = pkgs.fetchurl {
                url = "https://cdn2.steamgriddb.com/grid/121b81f7d167ca2c24fdab4f044048f8.png";
                hash = "sha256-Ko8grITApe49+aNvDbCPO9PWtCrvy4iR0yFlLHUCpbk=";
              };
              hero = pkgs.fetchurl {
                url = "https://cdn2.steamgriddb.com/hero/71d1c0c06e1ab5049644acb5cc69a090.png";
                hash = "sha256-0hJEKJN+zfQLwsz22TztTiqd/cvbhIzNkbmqjdusTyw=";
              };
              logo = pkgs.fetchurl {
                url = "https://cdn2.steamgriddb.com/logo/24df88ee05eb50db7d1d083a37f49b0b.png";
                hash = "sha256-LY38U5cZ4dRMwH8tvfR9uXH2wSy0qHL1vAtpt3Fcqj0=";
              };
            };
          };
        };
      };
  };
}
