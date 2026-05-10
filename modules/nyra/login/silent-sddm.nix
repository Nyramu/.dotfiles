{
  self,
  inputs,
  lib,
  ...
}:
{
  flake.modules.nixos = {
    login.imports = [ self.modules.nixos.silentSddm ];

    silentSddm =
      { config, user, ... }:

      let
        palette = config.stylix.base16Scheme;
        serif = config.stylix.fonts.serif.name;
        cfg = config.nyra.login.silentSDDM;

        bg-name = bg: if lib.isDerivation bg then bg.name else baseNameOf bg;
      in
      {
        imports = [ inputs.silentSDDM.nixosModules.default ];

        options.nyra.login.silentSDDM = {
          enable = lib.mkEnableOption "SilentSDDM theming";
        };

        config = lib.mkIf (cfg.enable) {
          programs.silentSDDM = rec {
            enable = true;
            backgrounds.stylix = config.stylix.image;
            profileIcons.${user.name} = user.pfp;
            settings = {
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
                shape = lib.mkDefault "square";
                active-size = 180;
                border-radius = 1;
                active-border-size = 2;
                active-border-color = palette.base0D;
              };
              "LoginScreen.LoginArea.LoginButton" = {
                font-family = serif;
                font-size = 24;
                icon-size = 30;
                content-color = palette.base0A;
                active-content-color = palette.base05;
                background-color = palette.base00;
                background-opacity = 0.6;
                active-background-color = palette.base00;
                active-background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
                hide-if-not-needed = true;
              };
              "LoginScreen.LoginArea.PasswordInput" = {
                width = 450;
                height = 60;
                font-family = serif;
                font-size = 24;
                display-icon = true;
                icon-size = 30;
                content-color = palette.base0A;
                background-color = palette.base00;
                background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
                margin-top = 20;
              };
              "LoginScreen.LoginArea.Spinner" = {
                text = "Logging in";
                display-text = true;
                font-family = serif;
                font-size = 36;
                icon-size = 72;
                color = palette.base05;
                spacing = 1;
              };
              "LoginScreen.LoginArea.Username" = {
                font-family = serif;
                font-size = 40;
                color = palette.base05;
                margin = 5;
              };
              "LoginScreen.LoginArea.WarningMessage" = {
                font-family = serif;
                font-size = 22;
                normal-color = palette.base05;
                warning-color = palette.base05;
                error-color = palette.base05;
              };
              "LoginScreen.MenuArea.Buttons" = {
                font-family = serif;
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
                content-color = palette.base0A;
                active-content-color = palette.base05;
                background-color = palette.base00;
                background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
              };
              "LoginScreen.MenuArea.Popups" = {
                max-height = 600;
                item-height = 60;
                item-spacing = 1;
                padding = 2;
                font-family = serif;
                font-size = 22;
                icon-size = 24;
                content-color = palette.base0A;
                active-content-color = palette.base05;
                background-color = palette.base00;
                background-opacity = 0.6;
                active-option-background-color = palette.base00;
                active-option-background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
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
                content-color = palette.base0A;
                active-content-color = palette.base05;
                background-color = palette.base00;
                background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
              };
              "LoginScreen.MenuArea.Session" = {
                index = 1;
                position = "bottom-center";
                button-width = 300;
                popup-width = 300;
                font-size = 25;
                icon-size = 32;
                content-color = palette.base0A;
                active-content-color = palette.base05;
                background-color = palette.base00;
                background-opacity = 0.6;
                active-background-opacity = 0.6;
                border-size = 1;
                border-color = palette.base0D;
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
                color = palette.base05;
                font-family = serif;
                font-size = 80;
              };
              "LockScreen.Date" = {
                display = true;
                margin-top = 1;
                format = "dd/MM/yyyy";
                locale = "it_IT";
                color = palette.base0A;
                font-family = serif;
                font-size = 28;
              };
              "LockScreen.Message" = {
                display = false;
                text = "Press any key";
                align = "center";
                position = "bottom-center";
                font-family = serif;
                font-size = 32;
                color = palette.base0A;
                icon-size = 44;
                paint-icon = true;
              };
              "Tooltips" = {
                enable = false;
                font-family = serif;
              };
            };
          };
        };
      };
  };
}
