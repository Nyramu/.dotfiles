{ config, lib, pkgs, ... }: with lib;

let
  cfg = config.nyra.system.security;
in
{
  options.nyra.system.security = {
    fprint.enable = mkEnableOption "Fingerprint support";
    fprint.sudoTimeout = mkOption {
      type = types.ints.positive;
      default = 3;
      description = "Fingerprint timeout (s) for sudo authentication (integer)";
    };
    fprint.sddmTimeout = mkOption {
      type = types.ints.positive;
      default = 2;
      description = "Fingerprint timeout (s) for sddm authentication (integer)";
    }; 
  };

  config = {
    # Enable fingerprint support
    services.fprintd = {
      enable = cfg.fprint.enable;
      #tod.enable = true; # For Touch OEM Drivers (Validity/Synaptics) sensors
      #tod.driver = pkgs.libfprint-2-tod1-goodix; # Adapts to your sensor
    };

    # Pam sudo and sddm config overrides due
    # to fingerprint timeout and priority 
    security.pam.services = mkIf (config.services.fprintd.enable) {
      # Enable fingerprint on sudo giving priority to fingerprint with 3 seconds timeout
      sudo.text = mkForce ''
        # Account management.
        account required ${pkgs.pam}/lib/security/pam_unix.so # unix (order 10900)
        # Authentication management.
        auth sufficient ${pkgs.fprintd}/lib/security/pam_fprintd.so timeout=${toString cfg.fprint.sudoTimeout} # fprintd (order 11400)
        auth sufficient ${pkgs.pam}/lib/security/pam_unix.so likeauth try_first_pass # unix (order 11600)
        auth required ${pkgs.pam}/lib/security/pam_deny.so # deny (order 12400)
        # Password management.
        password sufficient ${pkgs.pam}/lib/security/pam_unix.so nullok yescrypt # unix (order 10200)
        # Session management.
        session required ${pkgs.pam}/lib/security/pam_env.so conffile=/etc/pam/environment readenv=0 # env (order 10100)
        session required ${pkgs.pam}/lib/security/pam_unix.so # unix (order 10200)
        session required ${pkgs.pam}/lib/security/pam_limits.so # limits (order 12200)
      '';

      # Enable fingerprint log-in on sddm giving priority to password
      sddm.text = optionals (config.nyra.system.login.sddm.enable) mkForce ''
        auth      optional      ${pkgs.pam}/lib/security/pam_faildelay.so delay=2000000
        auth      sufficient    ${pkgs.pam}/lib/security/pam_unix.so try_first_pass nullok nodelay
        auth      sufficient    ${pkgs.fprintd}/lib/security/pam_fprintd.so timeout=${toString cfg.fprint.sddmTimeout}
        auth      required      ${pkgs.pam}/lib/security/pam_deny.so
        account   required      ${pkgs.pam}/lib/security/pam_unix.so
        password  required      ${pkgs.pam}/lib/security/pam_deny.so
        session   required      ${pkgs.pam}/lib/security/pam_unix.so
        session   optional      ${pkgs.systemd}/lib/security/pam_systemd.so
      '';
    };
  };
}
