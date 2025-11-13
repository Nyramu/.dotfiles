{ config, pkgs, inputs, ... }:

let
   themeName = config.nyra.theme.defaultTheme;
   theme = import ../../../../resources/themes/${themeName}.nix { inherit pkgs; };

   background-derivation = pkgs.runCommand "bg.jpg" {} ''
      cp ${theme.background} $out
   '';
in
{
   silentSDDM = inputs.silentSDDM.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
     extraBackgrounds = [ background-derivation ];
     theme-overrides = {
       "General" = {
         enable-animations = true;
       };
       "LoginScreen" = {
         background = "${background-derivation.name}";
         blur = 15;
       };
       "LoginScreen.LoginArea" = {
         position = "center";
         margin = -1;
       };
       "LoginScreen.LoginArea.Avatar" = {
         shape = "square";
         active-size = 180;
         border-radius = 1;
         active-border-size = 2;
         active-border-color = "#${theme.palette.base0D}";
       };
       "LoginScreen.LoginArea.LoginButton" = {
         font-size = 24;
         icon-size = 30;
         content-color = "#${theme.palette.base0A}";
         active-content-color = "#${theme.palette.base04}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         active-background-color = "#${theme.palette.base00}";
         active-background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}"; 
       };
       "LoginScreen.LoginArea.PasswordInput" = {
         width = 450;
         height = 60;
         font-size = 24;
         display-icon = true;
         icon-size = 30;
         content-color = "#${theme.palette.base0A}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}";
         margin-top = 20;
       };
       "LoginScreen.LoginArea.Spinner" = {
         text = "Logging in";
         font-size = 36;
         icon-size = 72;
         color = "#${theme.palette.base04}";
         spacing = 1;
       };
       "LoginScreen.LoginArea.Username" = {
         font-size = 40;
         color = "#${theme.palette.base04}";
         margin = 5;
       };
       "LoginScreen.LoginArea.WarningMessage" = {
         font-size = 22;
         normal-color = "#${theme.palette.base04}";
         warning-color = "#${theme.palette.base04}";
         error-color = "#${theme.palette.base04}";
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
         content-color = "#${theme.palette.base0A}";
         active-content-color = "#${theme.palette.base04}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}"; 
       };
       "LoginScreen.MenuArea.Popups" = {
         max-height = 600;
         item-height = 60;
         item-spacing = 1;
         padding = 2;
         font-size = 22;
         icon-size = 24;
         content-color = "#${theme.palette.base0A}";
         active-content-color = "#${theme.palette.base04}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         active-option-background-color = "#${theme.palette.base00}";
         active-option-background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}"; 
         display-scrollbar = true;
       };
       "LoginScreen.MenuArea.Power" = {
         index = 0;
         popup-width = 200;
         position = "bottom-center";
         icon-size = 32;
         content-color = "#${theme.palette.base0A}";
         active-content-color = "#${theme.palette.base04}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}";
       };
       "LoginScreen.MenuArea.Session" = {
         index = 1;
         position = "bottom-center";
         button-width = 300;
         popup-width = 300;
         font-size = 25;
         icon-size = 32;
         content-color = "#${theme.palette.base0A}";
         active-content-color = "#${theme.palette.base04}";
         background-color = "#${theme.palette.base00}";
         background-opacity = 0.6;
         active-background-opacity = 0.6;
         border-size = 1;
         border-color = "#${theme.palette.base0D}"; 
       };
       "LockScreen" = {
         background = "${background-derivation.name}";
         blur = 45;
       };
       "LockScreen.Clock" = {
         position = "center";
         align = "center";
         format = "hh:mm:ss";
         color = "#${theme.palette.base04}";
         font-size = 80;
       };
       "LockScreen.Date" = {
         margin-top = 1;
         format = "dd/MM/yyyy";
         locale = "it_IT";
         color = "#${theme.palette.base0A}";
         font-size = 28;
       };
       "LockScreen.Message" = {
         text = "Press any key";
         font-size = 32;
         color = "#${theme.palette.base0A}";
         icon-size = 44;
         paint-icon = true;
       };
       "Tooltips" = {
         enable = false;
       };
     };
   };
}
