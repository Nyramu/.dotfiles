{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:

let
  theme = import ../../../resources/themes/${config.nyra.theme.defaultTheme}.nix { inherit pkgs; };
  stylix = config.stylix;
  cfg = config.nyra.system.sddm;

  bg-name = bg: if lib.isDerivation bg then bg.name else baseNameOf bg;
in
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  options.nyra.system.sddm = {
    enable = lib.mkEnableOption "SDDM with silentSDDM theme";
    avatar = lib.mkOption {
      type = lib.types.enum [
        "burrito-ascii"
        "nyramu"
      ];
      default = "nyramu";
      description = "Icon file for the user";
    };
  };

  config = {
    services.displayManager.sddm = {
      enable = cfg.enable;
      enableHidpi = true;
      autoNumlock = true;
      wayland.enable = lib.mkForce true;
    };

    programs.silentSDDM = rec {
      enable = cfg.enable;
      backgrounds.stylix = lib.optionals (stylix.enable) stylix.image;
      profileIcons.nyramu = ../../../resources/${cfg.avatar}.png;
      settings = lib.mkIf (stylix.enable) {
        "General" = {
          enable-animations = true;
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
        };
        "LoginScreen.LoginArea.PasswordInput" = {
          width = 450;
          height = 60;
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
          font-size = 36;
          icon-size = 72;
          color = stylix.base16Scheme.base05;
          spacing = 1;
        };
        "LoginScreen.LoginArea.Username" = {
          font-size = 40;
          color = stylix.base16Scheme.base05;
          margin = 5;
        };
        "LoginScreen.LoginArea.WarningMessage" = {
          font-size = 22;
          normal-color = stylix.base16Scheme.base05;
          warning-color = stylix.base16Scheme.base05;
          error-color = stylix.base16Scheme.base05;
        };
        "LoginScreen.MenuArea.Buttons" = {
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
          popup-width = 200;
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
          background = bg-name backgrounds.stylix;
          blur = 45;
        };
        "LockScreen.Clock" = {
          position = "center";
          align = "center";
          format = "hh:mm:ss";
          color = stylix.base16Scheme.base05;
          font-size = 80;
        };
        "LockScreen.Date" = {
          margin-top = 1;
          format = "dd/MM/yyyy";
          locale = "it_IT";
          color = stylix.base16Scheme.base0A;
          font-size = 28;
        };
        "LockScreen.Message" = {
          text = "Press any key";
          font-size = 32;
          color = stylix.base16Scheme.base0A;
          icon-size = 44;
          paint-icon = true;
        };
        "Tooltips" = {
          enable = false;
        };
      };
    };
  };
}
