{ self, ... }:
{
  flake.modules.nixos = {
    core.imports = [ self.modules.nixos.hw-optimization ];

    hw-optimization =
      {
        pkgs,
        performance,
        gpu,
        ...
      }:

      let
        hasAmdGpu = (gpu.integrated.vendor == "amd" || gpu.dedicated.vendor == "amd");
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
          amdgpu.initrd.enable = hasAmdGpu;
          amdgpu.overdrive.enable = hasAmdGpu && performance != "potato";
          amdgpu.opencl.enable = hasAmdGpu;
          graphics.extraPackages = with pkgs; [
            libva
          ];
        };
        nixpkgs.config.rocmSupport = hasAmdGpu;
      };
  };
}
