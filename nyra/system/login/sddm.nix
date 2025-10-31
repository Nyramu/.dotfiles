{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.login;
in
{
  options.nyra.system.login = {
    sddm.enable = mkEnableOption "sddm";
  };

  config = mkIf (cfg.sddm.enable) {
    imports = [ ../theme/silent-sddm.nix ];
  
    services.displayManager.sddm = {
      enable = true;
      enableHidpi = true;
      autoNumlock = true;
      theme = sddm-theme.pname;
      wayland = {
        enable = true;
      };
      extraPackages = sddm-theme.propagatedBuildInputs;
    };

    environment.systemPackages = [ sddm-theme ];
  };
}