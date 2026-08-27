{ self, lib, ... }:
{
  flake.modules.nixos = {
    services.imports = [ self.modules.nixos.fingerprint ];

    fingerprint =
      { config, pkgs, ... }:

      let
        inherit (lib.types) ints;
        cfg = config.nyra.services.fingerprint;
      in
      {
        options.nyra.services.fingerprint = {
          enable = lib.mkEnableOption "fingerprint support";
          timeout = {
            sudo = lib.mkOption {
              type = ints.positive;
              default = 3;
              description = "Fingerprint timeout (in seconds) for sudo authentication";
            };
            sddm = lib.mkOption {
              type = ints.positive;
              default = 3;
              description = "Fingerprint timeout (in seconds) for sddm authentication";
            };
          };
        };

        config = lib.mkIf (cfg.enable) {
          services.fprintd = {
            enable = true;
            #tod.enable = true; # For Touch OEM Drivers (Validity/Synaptics) sensors
            #tod.driver = pkgs.libfprint-2-tod1-goodix; # Adapts to your sensor
          };

          security.pam.services = {
            sudo.text = lib.mkForce ''
              account required ${pkgs.pam}/lib/security/pam_unix.so
              auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so timeout=${toString cfg.timeout.sudo}
              auth sufficient ${pkgs.pam}/lib/security/pam_unix.so likeauth try_first_pass 
              auth required ${pkgs.pam}/lib/security/pam_deny.so
              password sufficient ${pkgs.pam}/lib/security/pam_unix.so nullok yescrypt
              session required ${pkgs.pam}/lib/security/pam_env.so conffile=/etc/pam/environment readenv=0
              session required ${pkgs.pam}/lib/security/pam_unix.so
              session required ${pkgs.pam}/lib/security/pam_limits.so
            '';

            sddm.text = lib.mkForce ''
              auth      optional      ${pkgs.pam}/lib/security/pam_faildelay.so delay=2000000
              auth      sufficient    ${pkgs.pam}/lib/security/pam_unix.so try_first_pass nullok nodelay
              auth      sufficient    ${pkgs.fprintd}/lib/security/pam_fprintd.so timeout=${toString cfg.timeout.sddm}
              auth      required      ${pkgs.pam}/lib/security/pam_deny.so
              account   required      ${pkgs.pam}/lib/security/pam_unix.so
              password  required      ${pkgs.pam}/lib/security/pam_deny.so
              session   required      ${pkgs.pam}/lib/security/pam_unix.so
              session   optional      ${pkgs.systemd}/lib/security/pam_systemd.so
            '';
          };
        };
      };
  };
}
