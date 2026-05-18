{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.hw-optimization ];

    hw-optimization =
      {
        pkgs,
        gpu,
        ...
      }:

      let
        isAmdGpu = (gpu.integrated.vendor == "amd" || gpu.dedicated.vendor == "amd");
      in
      {
        services.auto-cpufreq = {
          enable = true;
          settings = {
            battery = {
              governor = "powersave";
              turbo = "never";
            };
            charger = {
              governor = "performance";
              energy_performance_preference = "performance";
              platform_profile = "performance";
              turbo = "auto";
            };
          };
        };

        hardware = {
          amdgpu.initrd.enable = isAmdGpu;
          amdgpu.overdrive.enable = isAmdGpu;
          amdgpu.opencl.enable = isAmdGpu;
          graphics.extraPackages = with pkgs; [
            libva
          ];
        };
        nixpkgs.config.rocmSupport = isAmdGpu;
      };
  };
}
