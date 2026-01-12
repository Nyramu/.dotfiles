{ lib, pkgs, userSettings, ... }: with lib;

let
  screenShot = pkgs.callPackage ../../nyra/commands/screen-shot {};
  screenRecord = pkgs.callPackage ../../nyra/commands/screen-record {};
in
{
  imports = [
    ../../nyra/home
    ../../nyra/commands/nyra
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = userSettings.username;
    homeDirectory = "/home/${userSettings.username}";
    stateVersion = "26.05";
    packages = [screenShot screenRecord];
  };
  news.display = "silent";

  programs.home-manager.enable = true;

  # Use zsh by default
  nyra.home.shells.zsh.enable = true;

  # XDG configuration
  xdg = {
    enable = true;
    mimeApps = {
      enable = true;
      defaultApplications = let
        browser = ["zen-beta.desktop"];
        imageViewer = ["imv.desktop"];
        imageEditor = ["gimp.desktop"];
        videoViewer = ["mpv.desktop"];

        commonImages = ["image/png" "image/jpeg" "image/jpg" "image/gif" "image/webp" "image/bmp" "image/tiff" "image/svg+xml"];
        gimpFormats = ["image/x-xcf" "image/x-psd" "image/x-xcfgz"];

        videoFormats = ["video/mp4" "video/x-matroska" "video/webm" "video/mpeg" "video/x-msvideo" "video/quicktime" "video/x-flv" "video/ogg"];

        toMimeAttrs = formats: opener:
          formats
          |> map (n: {
            name = n;
            value = opener;
          })
          |> builtins.listToAttrs;
      in
        mkMerge [
          (toMimeAttrs commonImages imageViewer)
          (toMimeAttrs gimpFormats imageEditor)
          (toMimeAttrs videoFormats videoViewer)
          {
            "text/html" = browser;
            "application/xhtml+xml" = browser;
          }
        ];
    };
    desktopEntries = {
      imv = {
        name = "imv";
        exec = "${getExe pkgs.imv}";
      };
      mpv = {
        name = "mpv";
        exec = "${getExe pkgs.mpv} --keep-open=yes";
      };
    };
  };
}
