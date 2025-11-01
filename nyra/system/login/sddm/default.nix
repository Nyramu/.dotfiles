{ config, lib, pkgs, inputs, ... }: with lib;

let
  themeCfg = config.nyra.theme;
  sddmCfg = config.nyra.system.login.sddm;
  sddm-theme = import ./${sddmCfg.theme}.nix { inherit config lib pkgs inputs; };
in
{
  options.nyra.system.login.sddm = {
    enable = mkEnableOption "sddm";
    theme = mkOption {
      type = types.enum [ "silentSDDM" ];
      default = "silentSDDM";
      description = "Choose a theme for SDDM: silentSDDM";
    };
  };

  config = mkIf (sddmCfg.enable) {
      
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      autoNumlock = true;
      theme = mkIf (themeCfg.enable) sddm-theme.${sddmCfg.theme}.pname;
      wayland = {
        enable = true;
      };
      extraPackages = mkIf (themeCfg.enable) sddm-theme.${sddmCfg.theme}.propagatedBuildInputs;
    };

    environment.systemPackages = [ sddm-theme.${sddmCfg.theme} ];
  };
}
