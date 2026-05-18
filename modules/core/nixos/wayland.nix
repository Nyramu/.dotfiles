{ self, lib, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.wayland ];

    wayland =
      { wayland, pkgs, ... }:
      {
        # Needed for gpu-screen-recorder in a wayland context
        security.wrappers.gsr-kms-server = lib.mkIf (wayland.enable) {
          owner = "root";
          group = "root";
          capabilities = "cap_sys_admin+ep";
          source = "${pkgs.gpu-screen-recorder}/bin/gsr-kms-server";
          setuid = false;
          setgid = false;
        };
      };
  };
}
