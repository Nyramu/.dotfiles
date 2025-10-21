{ pkgs, inputs, ... }:

let
   theme = import ../themes/sunset.nix { inherit pkgs; };

   sddm-theme = inputs.silentSDDM.packages.${pkgs.system}.default.overrideAttrs (prev: {
    installPhase = ''
      ${prev.installPhase}
      cp ${theme.background} $out/share/sddm/themes/silent/backgrounds/default.jpg
      cp ${theme.background} $out/share/sddm/themes/silent/backgrounds/smoky.jpg
    '';
   });
in
{
  services.displayManager.sddm = {
    enable = true;
    enableHidpi = true;
    autoNumlock = true;
    theme = sddm-theme.pname;
    wayland = {
      enable = true;
    };
    extraPackages = sddm-theme.propagatedBuildInputs;
    settings = {
      # Required for styling the virtual keyboard
      General = {
        GreeterEnvironment = "QML2_IMPORT_PATH=${sddm-theme}/share/sddm/themes/${sddm-theme.pname}/components/,QT_IM_MODULE=qtvirtualkeyboard";
        InputMethod = "qtvirtualkeyboard";
      };
    }; 
  };

  environment.systemPackages = [ sddm-theme ];
}
