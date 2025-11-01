{ config, lib, pkgs, inputs, ... }: with lib;

let
  themeCfg = config.nyra.theme;
  sddmCfg = config.nyra.system.login.sddm;
  sddm-theme = import ../theme/silent-sddm.nix { inherit config lib pkgs inputs; };
in
{
  options.nyra.system.login = {
    sddm.enable = mkEnableOption "sddm";
  };

  config = mkIf (sddmCfg.enable) {
      
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      autoNumlock = true;
      theme = mkIf (themeCfg.enable) sddm-theme.silentSDDM.pname;
      wayland = {
        enable = true;
      };
      extraPackages = mkIf (themeCfg.enable) sddm-theme.silentSDDM.propagatedBuildInputs;
    };

    environment.systemPackages = [ sddm-theme.silentSDDM ];
  };
}
