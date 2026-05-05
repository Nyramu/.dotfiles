{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  nyraSettings = config.nyra.settings;
  theme = import config.nyra.theme.path { inherit pkgs; };
  stylix = config.stylix;
  cfg = config.nyra.services.sddm;

  bg-name = bg: if lib.isDerivation bg then bg.name else baseNameOf bg;
in
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  options.nyra.services.sddm = {
    enable = lib.mkEnableOption "SDDM with silentSDDM theme";
  };

  config = lib.mkIf (cfg.enable == true) {
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      autoNumlock = true;
      wayland.enable = lib.mkForce config.nyra.wayland.enable;
    };

    programs.silentSDDM = rec {
      enable = true;
      backgrounds.stylix = lib.optionals (stylix.enable) stylix.image;
      profileIcons.${nyraSettings.username} = nyraSettings.pfp;
      settings = lib.mkIf (stylix.enable) {
        "General" = {
          enable-animations = true;
          background-fill-mode = "fill";
        };
        "LoginScreen" = {
          background = bg-name backgrounds.stylix;
          blur = 15;
        };
        "LoginScreen.LoginArea" = {
          position = "center";
          margin = -1;
        };
        "LoginScreen.LoginArea.Avatar" = {
          shape = theme.silentSDDM.avatar-shape or "square";
          active-size = 180;
          border-radius = 1;
          active-border-size = 2;
          active-border-color = stylix.base16Scheme.base0D;
        };
        "LoginScreen.LoginArea.LoginButton" = {
          font-family = stylix.fonts.serif.name;
          font-size = 24;
          icon-size = 30;
          content-color = stylix.base16Scheme.base0A;
          active-content-color = stylix.base16Scheme.base05;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          active-background-color = stylix.base16Scheme.base00;
          active-background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
          hide-if-not-needed = true;
        };
        "LoginScreen.LoginArea.PasswordInput" = {
          width = 450;
          height = 60;
          font-family = stylix.fonts.serif.name;
          font-size = 24;
          display-icon = true;
          icon-size = 30;
          content-color = stylix.base16Scheme.base0A;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
          margin-top = 20;
        };
        "LoginScreen.LoginArea.Spinner" = {
          text = "Logging in";
          display-text = true;
          font-family = stylix.fonts.serif.name;
          font-size = 36;
          icon-size = 72;
          color = stylix.base16Scheme.base05;
          spacing = 1;
        };
        "LoginScreen.LoginArea.Username" = {
          font-family = stylix.fonts.serif.name;
          font-size = 40;
          color = stylix.base16Scheme.base05;
          margin = 5;
        };
        "LoginScreen.LoginArea.WarningMessage" = {
          font-family = stylix.fonts.serif.name;
          font-size = 22;
          normal-color = stylix.base16Scheme.base05;
          warning-color = stylix.base16Scheme.base05;
          error-color = stylix.base16Scheme.base05;
        };
        "LoginScreen.MenuArea.Buttons" = {
          font-family = stylix.fonts.serif.name;
          size = 60;
        };
        "LoginScreen.MenuArea.Keyboard" = {
          display = false;
        };
        "LoginScreen.MenuArea.Layout" = {
          index = 2;
          position = "bottom-center";
          font-size = 20;
          icon-size = 32;
          content-color = stylix.base16Scheme.base0A;
          active-content-color = stylix.base16Scheme.base05;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
        };
        "LoginScreen.MenuArea.Popups" = {
          max-height = 600;
          item-height = 60;
          item-spacing = 1;
          padding = 2;
          font-family = stylix.fonts.serif.name;
          font-size = 22;
          icon-size = 24;
          content-color = stylix.base16Scheme.base0A;
          active-content-color = stylix.base16Scheme.base05;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          active-option-background-color = stylix.base16Scheme.base00;
          active-option-background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
          display-scrollbar = true;
        };
        "LoginScreen.MenuArea.Power" = {
          index = 0;
          popup-direction = "up";
          popup-align = "center";
          popup-width = 200;
          display = true;
          position = "bottom-center";
          icon-size = 32;
          content-color = stylix.base16Scheme.base0A;
          active-content-color = stylix.base16Scheme.base05;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
        };
        "LoginScreen.MenuArea.Session" = {
          index = 1;
          position = "bottom-center";
          button-width = 300;
          popup-width = 300;
          font-size = 25;
          icon-size = 32;
          content-color = stylix.base16Scheme.base0A;
          active-content-color = stylix.base16Scheme.base05;
          background-color = stylix.base16Scheme.base00;
          background-opacity = 0.6;
          active-background-opacity = 0.6;
          border-size = 1;
          border-color = stylix.base16Scheme.base0D;
        };
        "LockScreen" = {
          display = true;
          background = bg-name backgrounds.stylix;
          blur = 45;
        };
        "LockScreen.Clock" = {
          display = true;
          position = "center";
          align = "center";
          format = "hh:mm:ss";
          color = stylix.base16Scheme.base05;
          font-family = stylix.fonts.serif.name;
          font-size = 80;
        };
        "LockScreen.Date" = {
          display = true;
          margin-top = 1;
          format = "dd/MM/yyyy";
          locale = "it_IT";
          color = stylix.base16Scheme.base0A;
          font-family = stylix.fonts.serif.name;
          font-size = 28;
        };
        "LockScreen.Message" = {
          display = false;
          text = "Press any key";
          align = "center";
          position = "bottom-center";
          font-family = stylix.fonts.serif.name;
          font-size = 32;
          color = stylix.base16Scheme.base0A;
          icon-size = 44;
          paint-icon = true;
        };
        "Tooltips" = {
          enable = false;
          font-family = stylix.fonts.serif.name;
        };
      };
    };
  };
}
